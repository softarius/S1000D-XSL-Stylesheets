echo PDFing... %~n1
del "%~n1.pdf"
xsltproc --xinclude -o "%~n1.fo" pdf.xsl "%~n1.xml" 
call fop -c c:\tools\fop-2.3\fop\conf\fop.xconf  "%~n1.fo" "%~n1.pdf"
rem del "%~n1.fo"
