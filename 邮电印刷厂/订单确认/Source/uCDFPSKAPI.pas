unit uCDFPSKAPI;

interface

        function  PTK_SetDarkness ( darkness:integer):integer;stdcall;
        function  PTK_SetPrintSpeed ( speed:integer):integer;stdcall;
        function  OpenPort    ( selection:integer):integer;stdcall;
        function  PTK_PrintLabel    ( number,cpnumber:Integer):integer;stdcall;
        function  PTK_DrawBarcode  ( px,py,pdirec:integer;typee:pchar;NarrowWidth,pHorizontal,pVertical:integer;ptext:char;pstr:pchar):integer;stdcall;
        Procedure ClosePort     ();stdcall;
        function  PTK_DrawTextTrueTypeW ( x,y,FHeight,FWidth:integer;FType:pchar;Fspin,FWeight,FItalic,FUnline,FStrikeOut:integer;id_name,data:pchar):integer;stdcall;
        Function GetErrState ():Integer;stdcall;
        function PTK_PcxGraphicsDel (pic:pchar):integer;stdcall;
        function PTK_SetLabelHeight(lheight,gapH:Integer):integer;stdcall;
        function PTK_SetLabelWidth(lwidth:Integer):integer;stdcall;
        function PTK_DrawText(px,py,pdirec,pFont,pHorizontal,pvertical:integer;ptext:char;pstr:Pchar):integer;stdcall;
        function SetPCComPort(BaudRate:Integer;HandShake:Boolean):integer;stdcall;
        function PTK_PcxGraphicsDownload(pcxname,pcxpath:pchar):integer;stdcall;
        function PTK_DrawPcxGraphics(x,y:Integer;gname:pchar):integer;stdcall;
        function PTK_DrawBar2D_Pdf417(x,y,w,v,s,c,px,py,r,l,t,o:Integer;LPTSTR:pchar):integer;stdcall;

implementation

        function  PTK_SetDarkness ( darkness:integer):integer;stdcall;external 'CDFPSK.DLL';
        function  PTK_SetPrintSpeed ( speed:integer):integer;stdcall;external 'CDFPSK.DLL';
        function  OpenPort    ( selection:integer):integer;stdcall;external 'CDFPSK.DLL';
        function  PTK_PrintLabel    ( number,cpnumber:Integer):integer;stdcall;external 'CDFPSK.DLL';
        function  PTK_DrawBarcode  ( px,py,pdirec:integer;typee:pchar;NarrowWidth,pHorizontal,pVertical:integer;ptext:char;pstr:pchar):integer;stdcall;external 'CDFPSK.DLL';
        Procedure ClosePort     ();stdcall;external 'CDFPSK.DLL';
        function  PTK_DrawTextTrueTypeW ( x,y,FHeight,FWidth:integer;FType:pchar;Fspin,FWeight,FItalic,FUnline,FStrikeOut:integer;id_name,data:pchar):integer;stdcall;external 'CDFPSK.DLL';
        Function GetErrState ():Integer;stdcall;external 'CDFPSK.DLL';
        function PTK_PcxGraphicsDel (pic:pchar):integer;stdcall;external 'cdfpsk.dll';
        function PTK_SetLabelHeight(lheight,gapH:Integer):integer;stdcall;external 'cdfpsk.dll';
        function PTK_SetLabelWidth(lwidth:Integer):integer;stdcall;external'cdfpsk.dll';
        function PTK_DrawText(px,py,pdirec,pFont,pHorizontal,pvertical:integer;ptext:char;pstr:Pchar):integer;stdcall;external 'CDFPSK.DLL';
        function SetPCComPort(BaudRate:Integer;HandShake:Boolean):integer;stdcall;external'cdfpsk.dll';
        function PTK_PcxGraphicsDownload(pcxname,pcxpath:pchar):integer;stdcall;external'cdfpsk.dll';
        function PTK_DrawPcxGraphics(x,y:Integer;gname:pchar):integer;stdcall;external'cdfpsk.dll';
        function PTK_DrawBar2D_Pdf417(x,y,w,v,s,c,px,py,r,l,t,o:Integer;LPTSTR:pchar):integer;stdcall;external'cdfpsk.dll';


end.
