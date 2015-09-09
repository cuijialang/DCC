
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include "PCIE.h"


#define PCIE_USER_BAR				PCIE_BAR0
#define PCIE_IO_LED_ADDR			0x00
#define PCIE_IO_SWITCH_ADDR		0xA0
#define PCIE_FIR_MEM_ADDR			0x20000

#define FIR_MEM_SIZE					(4*512) // 2048 Bytes

typedef enum{
	MENU_LED = 0,
	MENU_SWITCH,
	MENU_FIR_MEM_WR,
	MENU_QUIT = 99
}MENU_ID;

void UI_ShowMenu(void){
	printf("===TEST===========================\r\n");
	printf("[%d]: Led control\r\n", MENU_LED);
	printf("[%d]: Switch Status Read\r\n", MENU_SWITCH);
	printf("[%d]: FIR Memory Write\r\n", MENU_FIR_MEM_WR);
	printf("[%d]: Quit\r\n", MENU_QUIT);
	printf("Please input your selection:");
}

int UI_UserSelect(void){
	int nSel;
	scanf("%d",&nSel);
	return nSel;
}


BOOL TEST_LED(PCIE_HANDLE hPCIe){
	BOOL bPass;
	int	Mask;
	
	printf("Please input led control mask:");
	scanf("%d", &Mask);

	bPass = PCIE_Write32(hPCIe, PCIE_USER_BAR, PCIE_IO_LED_ADDR, (DWORD)Mask);
	if (bPass)
		printf("Led control success, mask=%xh\r\n", Mask);
	else
		printf("Led conrol failed\r\n");

	
	return bPass;
}

BOOL TEST_SWITCH(PCIE_HANDLE hPCIe){
	BOOL bPass = TRUE;
	DWORD Status;

	bPass = PCIE_Read32(hPCIe, PCIE_USER_BAR, PCIE_IO_SWITCH_ADDR, &Status);
	if (bPass)
		printf("Switch status mask=%xh\r\n", Status);
	else
		printf("Failed to read switch status\r\n");

	
	return bPass;
}

char PAT_GEN(int nIndex){
	char Data;
	Data = nIndex & 0xFF;
	return Data;
}

BOOL FIR_MEM_WR(PCIE_HANDLE hPCIe){
	BOOL bPass=TRUE;
	int i;
	const int nTestSize = FIR_MEM_SIZE;
	const PCIE_LOCAL_ADDRESS LocalAddr = PCIE_FIR_MEM_ADDR;
	char *pWrite;
	char *pRead;
	char szError[256];


	pWrite = (char *)malloc(nTestSize);
	pRead = (char *)malloc(nTestSize);
	if (!pWrite || !pRead){
		bPass = FALSE;
		sprintf(szError, "DMA Memory:malloc failed\r\n");
	}
	

	// init test pattern
	for(i=0;i<nTestSize && bPass;i++)
		*(pWrite+i) = PAT_GEN(i);

	// write test pattern
	if (bPass){
		bPass = PCIE_DmaWrite(hPCIe, LocalAddr, pWrite, nTestSize);
		if (!bPass)
			sprintf(szError, "DMA Memory:PCIE_DmaWrite failed\r\n");
	}		

	// read back test pattern and verify
	if (bPass){
		bPass = PCIE_DmaRead(hPCIe, LocalAddr, pRead, nTestSize);

		if (!bPass){
			sprintf(szError, "DMA Memory:PCIE_DmaRead failed\r\n");
		}else{
			for(i=0;i<nTestSize && bPass;i++){
				if (*(pRead+i) != PAT_GEN(i)){
					bPass = FALSE;
					sprintf(szError, "DMA Memory:Read-back verify unmatch, index = %d, read=%xh, expected=%xh\r\n", i, *(pRead+i), PAT_GEN(i));
				}
			}
		}
	}


	// free resource
	if (pWrite)
		free(pWrite);
	if (pRead)
		free(pRead);
	
	if (!bPass)
		printf("%s", szError);
	else
		printf("DMA-Memory (Size = %d byes) pass\r\n", nTestSize);


	return bPass;
}

int main(void)
{
	void *lib_handle;
	PCIE_HANDLE hPCIE;
	BOOL bQuit = FALSE;
	int nSel;

	printf("== DCC Program ==\r\n");

	lib_handle = PCIE_Load();
	if (!lib_handle){
		printf("PCIE_Load failed!\r\n");
		return 0;
	}

	hPCIE = PCIE_Open(0,0,0);
	if (!hPCIE){
		printf("PCIE_Open failed\r\n");
	}else{
		while(!bQuit){
			UI_ShowMenu();
			nSel = UI_UserSelect();
			switch(nSel){	
				case MENU_LED:
					TEST_LED(hPCIE);
					break;
				case MENU_SWITCH:
					TEST_SWITCH(hPCIE);
					break;
				case MENU_FIR_MEM_WR:
					FIR_MEM_WR(hPCIE);
					break;
				case MENU_QUIT:
					bQuit = TRUE;
					printf("Bye!\r\n");
					break;
				default:
					printf("Invalid selection\r\n");
			} // switch

		}// while

		PCIE_Close(hPCIE);

	}

	PCIE_Unload(lib_handle);
	return 0;
}
