#tag Module
Protected Module Whisper
	#tag Structure, Name = ContextParams, Flags = &h0
		use_gpu As Boolean
		gpu_device As Int32
	#tag EndStructure

	#tag Structure, Name = FullParams, Flags = &h0
		strategy As Int32
		  n_threads As Int32
		  n_max_text_ctx As Int32
		  offset_ms As Int32
		  duration_ms As Int32
		  translate As Boolean
		  no_context As Boolean
		  no_timestamps As Boolean
		  single_segment As Boolean
		  print_special As Boolean
		  print_progress As Boolean
		  print_realtime As Boolean
		  print_timestamps As Boolean
		  token_timestamps As Boolean
		  pad0 As UInt8
		  pad1 As UInt8
		  pad2 As UInt8
		  thold_pt As Single
		  thold_ptsum As Single
		  max_len As Int32
		  split_on_word As Boolean
		  pad3 As UInt8
		  pad4 As UInt8
		  pad5 As UInt8
		  max_tokens As Int32
		  speed_up As Boolean
		  debug_mode As Boolean
		  pad6 As UInt8
		  pad7 As UInt8
		  audio_ctx As Int32
		  tdrz_enable As Boolean
		  pad8 As UInt8
		  pad9 As UInt8
		  pad10 As UInt8
		  initial_prompt As Ptr            ' const char *
		  prompt_tokens As Ptr             ' const whisper_token *
		  prompt_n_tokens As Int32
		  pad11 As Int32
		  language As Ptr                  ' const char *
		  detect_language As Boolean
		  suppress_blank As Boolean
		  suppress_non_speech_tokens As Boolean
		  pad12 As UInt8                   ' pad to 4-byte boundary
		  temperature As Single
		  max_initial_ts As Single
		  length_penalty As Single
		  temperature_inc As Single
		  entropy_thold As Single
		  logprob_thold As Single
		  no_speech_thold As Single
		  greedy_best_of As Int32
		  greedy_pad As Int32
		  beam_size As Int32
		  beam_search_pad As Int32
		  patience As Single
		  patience_pad As Single
		  new_segment_callback As Ptr
		  new_segment_callback_user_data As Ptr
		  progress_callback As Ptr
		  progress_callback_user_data As Ptr
		  encoder_begin_callback As Ptr
		  encoder_begin_callback_user_data As Ptr
		  abort_callback As Ptr            ' ggml_abort_callback
		  abort_callback_user_data As Ptr
		  logits_filter_callback As Ptr
		  logits_filter_callback_user_data As Ptr
		  grammar_rules As Ptr             ' const whisper_grammar_element **
		  n_grammar_rules As UInt64        ' size_t
		  i_start_rule As UInt64           ' size_t
		  grammar_penalty As Single
		grammar_penalty_pad As Single    ' pad to 8-byte multiple
	#tag EndStructure


	#tag Enum, Name = ErrorEnum, Flags = &h0
		ContextFailure = 1
	#tag EndEnum


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
	#tag EndViewBehavior
End Module
#tag EndModule
