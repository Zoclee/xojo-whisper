#tag DesktopWindow
Begin DesktopWindow WindowMain
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   HasTitleBar     =   True
   Height          =   400
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1235564543
   MenuBarVisible  =   False
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   True
   Title           =   "Xojo Whisper"
   Type            =   0
   Visible         =   True
   Width           =   600
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function LoadWave(file As FolderItem, ByRef sampleCount As Int32) As MemoryBlock
		  If file = Nil Or Not file.Exists Then Return Nil
		  
		  Var bs As BinaryStream = BinaryStream.Open(file, False)
		  bs.LittleEndian = True
		  
		  ' Skip RIFF header (12 bytes: "RIFF", size, "WAVE")
		  Call bs.Read(12)
		  
		  ' Find "fmt " chunk
		  Var chunkID As String
		  Var chunkSize As UInt32
		  
		  Do Until bs.EndOfFile
		    chunkID = bs.Read(4)
		    chunkSize = bs.ReadUInt32
		    
		    If chunkID = "fmt " Then
		      Exit
		    Else
		      bs.Position = bs.Position + chunkSize
		    End If
		  Loop
		  
		  ' Read fmt chunk
		  Var audioFormat As UInt16 = bs.ReadUInt16
		  Var numChannels As UInt16 = bs.ReadUInt16
		  Var sampleRate As UInt32 = bs.ReadUInt32
		  Var byteRate As UInt32 = bs.ReadUInt32
		  Var blockAlign As UInt16 = bs.ReadUInt16
		  Var bitsPerSample As UInt16 = bs.ReadUInt16
		  
		  ' Skip any remaining fmt bytes
		  If chunkSize > 16 Then
		    bs.Position = bs.Position + (chunkSize - 16)
		  End If
		  
		  ' Find "data" chunk
		  Do Until bs.EndOfFile
		    chunkID = bs.Read(4)
		    chunkSize = bs.ReadUInt32
		    
		    If chunkID = "data" Then
		      Exit
		    Else
		      bs.Position = bs.Position + chunkSize
		    End If
		  Loop
		  
		  If chunkID <> "data" Then Return Nil
		  
		  ' Very basic checks
		  If audioFormat <> 1 Then Return Nil               ' PCM only
		  If bitsPerSample <> 16 Then Return Nil
		  If numChannels <> 1 Then Return Nil               ' mono only
		  If sampleRate <> 16000 Then Return Nil            ' Whisper expects 16 kHz
		  
		  ' Read samples
		  sampleCount = chunkSize / 2                       ' 16-bit -> 2 bytes per sample
		  Var mb As New MemoryBlock(sampleCount * 4)        ' float32 = 4 bytes
		  
		  For i As Int32 = 0 To sampleCount - 1
		    Var s As Int16 = bs.ReadInt16
		    Var f As Single = s / 32768.0
		    mb.SingleValue(i * 4) = f
		  Next
		  
		  Return mb
		End Function
	#tag EndMethod


#tag EndWindowCode

