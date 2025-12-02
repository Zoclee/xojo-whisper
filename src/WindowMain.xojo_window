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
   Height          =   348
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
   Begin DesktopButton ButtonOpenModel
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Open Model"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   28
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   19
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin DesktopLabel LabelModelPath
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   27
      Index           =   -2147483648
      Italic          =   False
      Left            =   132
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   0
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   448
   End
   Begin DesktopLabel LabelTranscription
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Transcription"
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   99
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
   Begin DesktopTextArea TextTranscription
      AllowAutoDeactivate=   True
      AllowFocusRing  =   True
      AllowSpellChecking=   True
      AllowStyledText =   True
      AllowTabs       =   False
      BackgroundColor =   &cFFFFFF
      Bold            =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Format          =   ""
      HasBorder       =   True
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      Height          =   197
      HideSelection   =   True
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LineHeight      =   0.0
      LineSpacing     =   1.0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      MaximumCharactersAllowed=   0
      Multiline       =   True
      ReadOnly        =   True
      Scope           =   2
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   ""
      TextAlignment   =   0
      TextColor       =   &c000000
      Tooltip         =   ""
      Top             =   131
      Transparent     =   False
      Underline       =   False
      UnicodeMode     =   1
      ValidationMask  =   ""
      Visible         =   True
      Width           =   560
   End
   Begin DesktopButton ButtonLoadAudio
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Load Audio"
      Default         =   False
      Enabled         =   False
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   28
      Index           =   -2147483648
      Italic          =   False
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      MacButtonStyle  =   0
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   59
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   100
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Method, Flags = &h21
		Private Function LoadWAV(file As FolderItem, ByRef sampleCount As Int32) As MemoryBlock
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


	#tag Property, Flags = &h0
		CurrentModel As Whisper.Model
	#tag EndProperty


#tag EndWindowCode

#tag Events ButtonOpenModel
	#tag Event
		Sub Pressed()
		  Var f As FolderItem
		  Var dlg As new OpenFileDialog
		  Var whisperType As new FileType
		  
		  whisperType.Name = "Whisper Model"
		  whisperType.Extensions = ".bin"
		  
		  dlg.Filter = whisperType
		  
		  f = dlg.ShowModal()
		  
		  if f <> nil then
		    
		    LabelModelPath.Text = "Loading model, please wait..."
		    LabelModelPath.Refresh(true)
		    
		    try 
		      CurrentModel = new Whisper.Model(f)
		      LabelModelPath.Text = CurrentModel.ModelPath.NativePath
		      ButtonLoadAudio.Enabled = true
		      LabelTranscription.Enabled = true
		      TextTranscription.Enabled = true
		    catch e As Whisper.ModelException
		      LabelModelPath.Text = e.Message
		      ButtonLoadAudio.Enabled = false
		      LabelTranscription.Enabled = false
		      TextTranscription.Enabled = false
		    end try 
		    
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ButtonLoadAudio
	#tag Event
		Sub Pressed()
		  Var f As FolderItem
		  Var dlg As new OpenFileDialog
		  Var wavType As new FileType
		  Var audio As MemoryBlock
		  Var nSamples As Int32
		  
		  wavType.Name = "WAV Audio File"
		  wavType.Extensions = ".wav"
		  
		  dlg.Filter = wavType
		  
		  f = dlg.ShowModal()
		  
		  if f <> nil then
		    
		    audio = LoadWAV(f, nSamples)
		    If audio Is Nil Then
		      MessageBox("Failed to load WAV / wrong format (need mono 16kHz 16-bit PCM)")
		    else
		      TextTranscription.Text = CurrentModel.Infer(audio, nSamples)
		    End If
		    
		  end if
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasTitleBar"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
