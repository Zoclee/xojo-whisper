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
