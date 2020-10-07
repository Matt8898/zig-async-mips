OUTPUT_ARCH(mips)
ENTRY(_start)

SECTIONS
{
  . = 0x81000000;
  .text : {
    *(.text)
	*(.rodata)
	*(.rodata1)
	*(.rodata.str1.4)
    }

  .reginfo : { *(.reginfo) }

  .date : {
	*(.data)
	}

  .bss  : {
	*(.dynbss)
	*(.bss)
  }
}

