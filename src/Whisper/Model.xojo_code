#tag Class
Protected Class Model
	#tag Method, Flags = &h0
		Sub Constructor(initModelPath As FolderItem)
		  Soft Declare Function whisper_init_from_file_with_params Lib "whisper.dll" (path_model As CString, ByRef params As ContextParams) As Ptr
		  
		  Var e As Whisper.ModelException
		  Var ctxParams As ContextParams
		  
		  ModelPath = initModelPath
		  
		  ctxParams.use_gpu = False ' Context params (disable GPU for now)
		  ctxParams.gpu_device = 0
		  
		  mContext = whisper_init_from_file_with_params(ModelPath.NativePath, ctxParams)
		  If mContext = Nil Then
		    e = new Whisper.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.ContextFailure)
		    e.Message = "Failed to initialize Whisper context."
		    Raise e
		  end if
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Soft Declare Sub whisper_free Lib "whisper.dll" (ctx As Ptr)
		  
		  if mContext <> nil then
		    whisper_free(mContext)
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Infer(audio As MemoryBlock, nSamples As Int32) As String
		  Soft Declare Function whisper_full_default_params Lib "whisper.dll" (strategy As Int32) As FullParams
		  Soft Declare Function whisper_full Lib "whisper.dll" (ctx As Ptr, byref params As FullParams, samples As Ptr, n_samples As Int32) As Int32
		  Soft Declare Function whisper_full_n_segments Lib "whisper.dll" (ctx As Ptr) As Int32
		  Soft Declare Function whisper_full_get_segment_text Lib "whisper.dll" (ctx As Ptr, segment As Int32) As CString
		  
		  Var e As Whisper.ModelException
		  Var params As FullParams
		  Var res As Int32
		  Var segCount As Int32
		  Var transcript As String
		  Var segText As String 
		  
		  ' Default full() params (greedy)
		  params = whisper_full_default_params(WHISPER_SAMPLING_GREEDY)
		  
		  ' Customise a few useful fields
		  params.n_threads = 4
		  params.print_progress = False
		  params.print_realtime = False
		  params.print_timestamps = False
		  params.translate = False                 ' transcribe (not translate)
		  params.no_timestamps = False             ' keep timestamps internally
		  
		  ' Language = "auto" (null/empty/"auto" → auto-detect in upstream) 
		  params.language = Nil
		  params.detect_language = True
		  
		  ' Run transcription
		  res = whisper_full(mContext, params, audio, nSamples)
		  If res <> 0 Then
		    e = new Whisper.ModelException()
		    e.ErrorNumber = Integer(ErrorEnum.TranscriptionError)
		    e.Message = "whisper_full failed with code " + res.ToString
		    Raise e
		  End If
		  
		  ' Collect segments
		  segCount = whisper_full_n_segments(mContext)
		  
		  For i As Int32 = 0 To segCount - 1
		    segText = whisper_full_get_segment_text(mContext, i)
		    transcript = transcript + segText + " "
		  Next
		  
		  Return transcript
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private mContext As Ptr
	#tag EndProperty

	#tag Property, Flags = &h0
		ModelPath As FolderItem
	#tag EndProperty


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
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ModelPath"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
