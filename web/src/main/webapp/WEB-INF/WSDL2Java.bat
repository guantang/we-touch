set Axis_Lib=E:\Axis_WSDLTOJAVA\axis-1_4\lib
set Java_Cmd=java -Djava.ext.dirs=%Axis_Lib%
set Output_Path=E:\ccproxy\core\src\main\java
set Package=com.webservice.client.pp
%Java_Cmd% org.apache.axis.wsdl.WSDL2Java -o%Output_Path% -p%Package% http://10.12.100.27/querycustomer/rss_service.php?wsdl
pause