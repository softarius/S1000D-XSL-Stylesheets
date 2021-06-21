echo PDFing... %~n1
del "%~n1.pdf"
xsltproc --xinclude -o "%~n1-db.xml"  ..\s1000dtodb\s1000dtodb.xsl  "%~n1.xml" 
xsltproc --xinclude -o "%~n1.fo" ..\dbtofo\dbtofo.xsl "%~n1-db.xml" 
call fop -c d:\tools\fop-2.6\fop\fop.xml "%~n1.fo" "%~n1.pdf"
rem del "%~n1.fo"
rem del "%~n1-db.xml"