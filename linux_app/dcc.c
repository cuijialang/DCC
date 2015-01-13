
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include "PCIE.h"


#define PCIE_USER_BAR				PCIE_BAR0
#define PCIE_IO_LED_ADDR			0x00
#define PCIE_FIFO_STATUS_ADDR		0x60
#define PCIE_FIFO_READ_ADDR		0x80
#define PCIE_IO_SWITCH_ADDR		0xA0
#define PCIE_FIR_COEFF_ADDR		0x2000

//#define FIFO_SIZE			(16*1024) // 2KBx8 -- 2k depth and 64 wide
#define FIFO_SIZE			(32*1024) // 



typedef enum{
	MENU_LED = 0,
	MENU_SWITCH,
	MENU_DMA_FIFO,
	MENU_FIR_COEFF,
	MENU_QUIT = 99
}MENU_ID;

int CheckFifoLevel(PCIE_HANDLE hPCIe){
	BOOL bPass = TRUE;
	DWORD Status;

	bPass = PCIE_Read32(hPCIe, PCIE_USER_BAR, PCIE_FIFO_STATUS_ADDR, &Status);
	if (bPass)
		printf("Fifo Level filled =%xh\r\n", Status);
	else
		printf("Failed to read Fifo Level filled\r\n");

	int intStatus;
	intStatus = (int)Status;
	return intStatus;
}

void UI_ShowMenu(void){
	printf("===TEST===========================\r\n");
	printf("[%d]: Led control\r\n", MENU_LED);
	printf("[%d]: Switch Status Read\r\n", MENU_SWITCH);
	printf("[%d]: DMA Fifo Test\r\n", MENU_DMA_FIFO);
	printf("[%d]: FIR Coeff\r\n", MENU_FIR_COEFF);
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
	
	printf("Please input led conrol mask:");
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

BOOL TEST_DMA_FIFO(PCIE_HANDLE hPCIe){
	BOOL bPass=TRUE;
	int i;
	int nTestSize;
	nTestSize = CheckFifoLevel(hPCIe); 
	printf("nTestSize: %d\n", nTestSize);
	//const int nTestSize = FIFO_SIZE;
	printf("FIFO_SIZE: %d\n", FIFO_SIZE);

	const PCIE_LOCAL_ADDRESS FifoID_Read = PCIE_FIFO_READ_ADDR;
	
	char szError[256];
	DWORD Status;
	
	/*###################### DMA not working properly Jan 06 2015
	DWORD *pBuff;
	pBuff = (DWORD *)malloc(nTestSize);
	if (!pBuff){
		bPass = FALSE;
		sprintf(szError, "DMA Fifo: malloc failed\r\n");
	}
	*/

	// read back
	if (bPass){
		/*###################### DMA not working properly Jan 06 2015	
		// check file in app.c for change back
		memset(pBuff, 0, nTestSize); // reset buffer content
		bPass = PCIE_DmaFifoRead(hPCIe, FifoID_Read, pBuff, nTestSize);
		*/
		FILE *fileOut=fopen("DataOut.txt","a");		
		for(i=0;i<nTestSize;i++){		// open file once and write all data
			bPass = PCIE_Read32(hPCIe, PCIE_USER_BAR, FifoID_Read, &Status);
			if (!bPass){
				sprintf(szError, "Fifo: PCIE_Read32 failed\r\n");
			}else{
				fprintf(fileOut,"0x%08x\n", Status);
				/*###################### DMA not working properly Jan 06 2015	
				for(i=0;i<nTestSize;i++){
					// write to file 
					fprintf(fileOut,"0x%08x\n",*(pBuff+i));
				}
				*/	
				if (i == nTestSize - 50){
					CheckFifoLevel(hPCIe); 
				}
			}
		}
		fclose(fileOut);
	}

	/*###################### DMA not working properly Jan 06 2015	
	// free resource
	if (pBuff)
		free(pBuff);
	*/
	if (!bPass)
		printf("%s", szError);
	else
		printf("DMA-Fifo (Size = %d byes) pass\r\n", nTestSize);


	return bPass;
}

BOOL TEST_FIR_COEFF(PCIE_HANDLE hPCIe){
	BOOL bPass = TRUE;
	DWORD Status;
	int nSel,i;
	
	printf("Please type 1 for Reading or 2 for writing\r\n");
	scanf("%d", &nSel);
	printf("Sel= %d",nSel);
	if (nSel == 1){
		printf("reading");
		//FILE *fileOut=fopen("FirCoeff.txt","a");		
		for(i=0;i<37;i++){		// open file once and write all data
			bPass = PCIE_Read32(hPCIe, PCIE_USER_BAR, PCIE_FIR_COEFF_ADDR + i, &Status);
			printf("0x%08x" , PCIE_FIR_COEFF_ADDR + i);
			if (!bPass){
				printf("FIR COEFF: PCIE_Read32 failed\r\n");
			}else{
				printf("%d: 0x%04x\t%d\n", i, Status, Status);
				//fprintf(fileOut,"i: 0x%08x\t%d\n", Status, Status);
			}
		}
		//fclose(fileOut);
	}else if (nSel == 2){
		printf("writing");
	}
	
	return bPass;
}


int main(void)
{
	void *lib_handle;
	PCIE_HANDLE hPCIE;
	BOOL bQuit = FALSE;
	int nSel;

	printf("== Terasic: PCIe Demo Program ==\r\n");

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
				case MENU_DMA_FIFO:
					TEST_DMA_FIFO(hPCIE);
					break;
				case MENU_FIR_COEFF:
					TEST_FIR_COEFF(hPCIE);
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
