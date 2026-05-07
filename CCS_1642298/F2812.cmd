/****************************************************************************/
/*   realtime.cmd - Sample linker command file for F28xx devices            */
/*                                                                          */
/*   Description: This file is a sample F2812 linker command file that can  */
/*                be used for linking programs built with the TMS320C2000   */
/*                C Compiler. Use it as a guideline; you may want to change */
/*                the allocation scheme according to the size of your       */
/*                program and the memory layout of your target system.      */
/****************************************************************************/

MEMORY
{
	PAGE 0:
		BOOT(R)		: origin = 0x3F8000, length = 0x0080
		RAMH0(R)	: origin = 0x3F8080, length = 0x1F80
		RESET(R)	: origin = 0x3FFFC0, length = 0x0002

	PAGE 1:
		RAMM0(RW)	: origin = 0x000000, length = 0x0400
		RAMM1(RW)	: origin = 0x000400, length = 0x0400
		RAML0(RW)	: origin = 0x008000, length = 0x1000
		RAML1(RW)	: origin = 0x009000, length = 0x1000
}
 
SECTIONS
{
	.cinit			: >	RAMH0,			PAGE = 0,	FILL = 0x0000
	.const			: >>RAML0 | RAML1,	PAGE = 1,	FILL = 0x0000
	.reset			: > RESET,			PAGE = 0,	TYPE = DSECT
	.text			: >	RAMH0,			PAGE = 0,	FILL = 0x0000

	.bss			: >>RAML0 | RAML1,	PAGE = 1,	FILL = 0x0000
	.data			: >>RAML0 | RAML1,	PAGE = 1,	FILL = 0x0000
	.stack			: >	RAMM0,			PAGE = 1,	FILL = 0x0000

	.boot > BOOT
	{
		-lrts2800_ml_eabi.lib<boot28.asm.obj> (.text)
	}
}
