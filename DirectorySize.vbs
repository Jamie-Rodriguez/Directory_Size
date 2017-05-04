' fso:		FileSystemObject for grabbing the directory
' f:		handle to the directory returned by fso
' strFolder:	directory path as a string, read from console input
' sizeInfo:	array for storing size info from the return value of Convert(), should be a array[2] of [size, units]
Dim fso, f, strFolder, sizeInfo
Set fso = CreateObject("Scripting.FileSystemObject")

' Values for converting from bytes to a larger format (binary based)
Dim Kib, MiB, GiB
' These size variables should be treated as constants.
' Const expects a literal string, so can't write KiB = 2^10, MiB = 2^20, GiB = 2^30 etc :(
KiB = 2^10 '1 kibibyte = 2^10 bytes = 1024 bytes
MiB = 2^20 '1 mebibyte = 2^20 bytes = 1,048,576 bytes (2^10 kibibytes)
GiB = 2^30 '1 gibibyte = 2^30 bytes = 1,073,741,824 bytes (2^10 mebibytes, 2^20 kibibytes)


' Returns an array of the size converted to the largest unit and a string of the unit.
' Largest unit is determined such that the units measured in are greater than one.
' i.e. number = 954,545,644 bytes will output array = [910.33, "MiB"]
Function convert(number) ' number must be a size in bytes
	Dim units

	If number < KiB Then
		units = "bytes"
	ElseIf number < MiB Then
		number = number / KiB
		units = "KiB"
	ElseIf number < GiB Then
		number = number / MiB
		units = "MiB"
	Else
		number = number / GiB
		units = "GiB"
	End If

	convert = Array(number, units) ' return values
End Function


' Asking for user input:
Do
	WScript.StdOut.Write "Please enter directory name: "
	strFolder = WScript.StdIn.ReadLine
	If fso.FolderExists(strFolder) Then 
		Exit Do
	Else
		WScript.StdOut.WriteLine "Invalid Directory ... Try Again"
	End If 
Loop

Set f = fso.GetFolder(strFolder)
sizeInfo = convert(f.Size)

WScript.StdOut.WriteLine "Size of " & f.Path & ":"
'WScript.Echo f.Path & ": " & FormatNumber(f.Size,0,,TriStateTrue) & " bytes"
WScript.StdOut.WriteLine FormatNumber(sizeInfo(0),2) & " " & sizeInfo(1)
