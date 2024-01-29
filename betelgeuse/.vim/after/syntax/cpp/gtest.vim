" Vim syntax file
" Language:	misc library C++ 
"

" google test.

syntax keyword cppGtestNamespace    testing

syntax keyword cppGtestMacro    TEST
syntax keyword cppGtestMacro    TEST_F

syntax keyword cppGtestMacro    RUN_ALL_TESTS

syntax keyword cppGtestMacro    ASSERT_EQ
syntax keyword cppGtestMacro    ASSERT_NE
syntax keyword cppGtestMacro    ASSERT_GT
syntax keyword cppGtestMacro    ASSERT_GE
syntax keyword cppGtestMacro    ASSERT_LT
syntax keyword cppGtestMacro    ASSERT_LE
syntax keyword cppGtestMacro    ASSERT_TRUE
syntax keyword cppGtestMacro    ASSERT_FALSE
syntax keyword cppGtestMacro    ASSERT_STREQ
syntax keyword cppGtestMacro    ASSERT_STRNE
syntax keyword cppGtestMacro    ASSERT_STRCASEEQ
syntax keyword cppGtestMacro    ASSERT_STRCASENE
syntax keyword cppGtestMacro    ASSERT_THROW
syntax keyword cppGtestMacro    ASSERT_ANY_THROW
syntax keyword cppGtestMacro    ASSERT_NO_THROW
syntax keyword cppGtestMacro    ASSERT_PRED1
syntax keyword cppGtestMacro    ASSERT_PRED2
syntax keyword cppGtestMacro    ASSERT_PRED_FORMAT1
syntax keyword cppGtestMacro    ASSERT_PRED_FORMAT2
syntax keyword cppGtestMacro    ASSERT_FLOAT_EQ
syntax keyword cppGtestMacro    ASSERT_DOUBLE_EQ
syntax keyword cppGtestMacro    ASSERT_NEAR
syntax keyword cppGtestMacro    ASSERT_DEATH
syntax keyword cppGtestMacro    ASSERT_EXIT
syntax keyword cppGtestMacro    ASSERT_NO_FATAL_FAILURE

syntax keyword cppGtestMacro    EXPECT_EQ
syntax keyword cppGtestMacro    EXPECT_NE
syntax keyword cppGtestMacro    EXPECT_GT
syntax keyword cppGtestMacro    EXPECT_GE
syntax keyword cppGtestMacro    EXPECT_LT
syntax keyword cppGtestMacro    EXPECT_LE
syntax keyword cppGtestMacro    EXPECT_TRUE
syntax keyword cppGtestMacro    EXPECT_FALSE
syntax keyword cppGtestMacro    EXPECT_STREQ
syntax keyword cppGtestMacro    EXPECT_STRNE
syntax keyword cppGtestMacro    EXPECT_STRCASEEQ
syntax keyword cppGtestMacro    EXPECT_STRCASENE
syntax keyword cppGtestMacro    EXPECT_THROW
syntax keyword cppGtestMacro    EXPECT_ANY_THROW
syntax keyword cppGtestMacro    EXPECT_NO_THROW
syntax keyword cppGtestMacro    EXPECT_PRED1
syntax keyword cppGtestMacro    EXPECT_PRED2
syntax keyword cppGtestMacro    EXPECT_PRED_FORMAT1
syntax keyword cppGtestMacro    EXPECT_PRED_FORMAT2
syntax keyword cppGtestMacro    EXPECT_FLOAT_EQ
syntax keyword cppGtestMacro    EXPECT_DOUBLE_EQ
syntax keyword cppGtestMacro    EXPECT_NEAR
syntax keyword cppGtestMacro    EXPECT_DEATH
syntax keyword cppGtestMacro    EXPECT_EXIT
syntax keyword cppGtestMacro    EXPECT_NO_FATAL_FAILURE

syntax keyword cppGtestMacro    SUCCEED
syntax keyword cppGtestMacro    FAIL
syntax keyword cppGtestMacro    SCOPED_TRACE

syntax keyword cppGtestMacro    MOCK_METHOD0
syntax keyword cppGtestMacro    MOCK_METHOD1
syntax keyword cppGtestMacro    MOCK_METHOD2
syntax keyword cppGtestMacro    MOCK_METHOD3
syntax keyword cppGtestMacro    MOCK_METHOD4
syntax keyword cppGtestMacro    MOCK_METHOD5
syntax keyword cppGtestMacro    MOCK_METHOD6
syntax keyword cppGtestMacro    MOCK_METHOD7
syntax keyword cppGtestMacro    MOCK_METHOD8
syntax keyword cppGtestMacro    MOCK_METHOD9
syntax keyword cppGtestMacro    MOCK_CONST_METHOD0
syntax keyword cppGtestMacro    MOCK_CONST_METHOD1
syntax keyword cppGtestMacro    MOCK_CONST_METHOD2
syntax keyword cppGtestMacro    MOCK_CONST_METHOD3
syntax keyword cppGtestMacro    MOCK_CONST_METHOD4
syntax keyword cppGtestMacro    MOCK_CONST_METHOD5
syntax keyword cppGtestMacro    MOCK_CONST_METHOD6
syntax keyword cppGtestMacro    MOCK_CONST_METHOD7
syntax keyword cppGtestMacro    MOCK_CONST_METHOD8
syntax keyword cppGtestMacro    MOCK_CONST_METHOD9

syntax keyword cppGtestMacro    EXPECT_CALL
syntax keyword cppGtestMacro    ON_CALL

syntax keyword cppGtestType     Test
syntax keyword cppGtestType     Environment
syntax keyword cppGtestType     WithParamInterface
syntax keyword cppGtestType     InSequence
syntax keyword cppGtestType     InvokeWithoutArgs
syntax keyword cppGtestType     Invoke
syntax keyword cppGtestType     Ref
syntax keyword cppGtestType     NiceMock
syntax keyword cppGtestType     StrictMock
syntax keyword cppGtestType     Return
syntax keyword cppGtestType     ReturnRef
syntax keyword cppGtestType     Const
syntax keyword cppGtestType     Matcher
syntax keyword cppGtestType     TypedEq
syntax keyword cppGtestType     An

syntax keyword cppGtestFunction ExitedWithCode
syntax keyword cppGtestFunction KilledBySignal
syntax keyword cppGtestFunction RecordProperty
syntax keyword cppGtestFunction SetUp
syntax keyword cppGtestFunction TearDown
syntax keyword cppGtestFunction AddGlobalTestEnvironment

syntax keyword cppGtestFunction AtLeast
syntax keyword cppGtestFunction Times
syntax keyword cppGtestFunction WillOnce
syntax keyword cppGtestFunction WillRepeatedly
syntax keyword cppGtestFunction WillByDefault
syntax keyword cppGtestFunction RetiresOnSaturation
syntax keyword cppGtestFunction InitGoogleMock

" Default highlighting
if version >= 508 || !exists("did_cpp_syntax_inits")
  if version < 508
    let did_cpp_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink cppGtestNamespace  Constant
  HiLink cppGtestMacro      Constant
  HiLink cppGtestType       Typedef
  HiLink cppGtestConstant   Constant
  HiLink cppGtestFunction   Function
  delcommand HiLink
endif
