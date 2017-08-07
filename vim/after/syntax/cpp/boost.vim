" Vim syntax file
" Language:	C++ special highlighting for boost classes and methods
" Maintainer:	Sebastien F.
" Last Change:	2012/01/01

syn keyword cppNS		boost abi tbb mpl hana range
syn keyword cppBoost		lambda _1 _2 _3 _4 _5 _6 _7 _8 _9 bind to_upper split is_space iterator_range find_last find_first regex regex_match smatch tokenizer char_separator escaped_list_separator asio async_send_to placeholders async_receive_from udp tcp run ip v4 apply_visitor add_options add store variables_map notify default_value rebind posix_time async_wait expires_from_now expires_at wrap join async_accept async_read_some bytes_transferred async_write shared_from_this interprocess create_only get_segment_manager get_free_memory get_address_from_handle get_handle_from_address wait get_address notify_all read_write open_only lexical_cast multicast join_group reuse_address set_option protocol from_string unit_test BOOST_CHECK BOOST_STATIC_ASSERT BOOST_TEST_SUITE BOOST_AUTO_TEST_CASE test_suite BOOST_PARAM_TEST_CASE framework results phoenix spirit qi ascii __cxa_demangle name grammar double_ char_ int_ debug space_type symbols eps _val string_parser fusion make_pair BOOST_FUSION_ADAPT_STRUCT BOOST_FOREACH lexeme _r1 _r2 _r3 _r4 _r5 _r6 _r7 _r8 _r9 lit at_c on_error val phrase_parse space now task allocate_child spawn allocate_root automatic microsec_clock local_time multi_array matrix extents type_c is_valid BOOST_HANA_DEFINE_STRUCT  nothing unpack BOOST_HANA_RUNTIME_CHECK BOOST_HANA_CONSTANT_CHECK BOOST_HANA_CONSTEXPR_CHECK BOOST_HANA_STRING full map_values map_keys transformed filter bool_c
syn keyword cppBoostType		circular_buffer io_service array endpoint buffer shared_ptr error error_code socket deadline_timer seconds microseconds milliseconds address static_visitor variant ptr_vector options_description program_options positional_options_description value options pointer_to_other strand thread acceptor enable_shared_from_this noncopyable aligned_storage shared_memory_object managed_shared_memory segment_manager handle_t offset_ptr interprocess_condition interprocess_mutex scoped_lock interprocess_exception mapped_region bad_lexical_cast test_results results_collector unused_type recursive_wrapper rule locals base_type tick_count task_scheduler_init any any_cast unsafe_any_cast tuple_t


" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppNS 				Statement
  HiLink cppBoost				Identifier
  HiLink cppBoostType      Type
  delcommand HiLink
endif

