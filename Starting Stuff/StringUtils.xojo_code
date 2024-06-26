#tag Module
Protected Module StringUtils
	#tag Method, Flags = &h1
		Protected Function Chop(s As String, charsToCut As Integer) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return s with the rightmost 'charsToCut' chars removed.
		  
		  return s.Left( s.Len - charsToCut )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ChopB(s As String, bytesToCut As Integer) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return s with the rightmost 'bytesToCut' bytes removed.
		  
		  return s.LeftB( s.LenB - bytesToCut )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function chunkify(param1 as string) As string()
		  
		  Dim startpos As Integer = 0
		  Dim endpos As Integer = 0
		  Dim workingString As String = param1
		  Dim chunks() As String
		  
		  While InStr(workingString, "{") > 0
		    
		    // find the chunk from 0 to {
		    startpos = InStr(workingString, "{")
		    
		    endpos = InStr(workingString, "}")
		    
		    Dim beforeBraceChunk As String = Left(workingString, startPos-1)
		    Dim betweenBraceChunk As String = Mid(workingString, startpos, endPos - startpos+1)
		    
		    chunks.append beforeBraceChunk
		    chunks.append  betweenBraceChunk
		    
		    // and now working is everything after the }
		    workingString = Mid(workingString, endpos + 1)
		    
		  Wend
		  
		  If workingString <> "" Then
		    chunks.append workingString
		  End If
		  
		  Return chunks
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CompareVerionsCodes(extends selfString as string, otherVersionString as string) As integer
		  Const kSelfLessThanOther = -1
		  Const kSelfEqualOther = 0
		  Const kSelfGreaterThanOther = 1
		  
		  // consistent with operator_compare 
		  // Operator_Compare returns an integer whose meaning is as follows: 
		  //  < 0 means that selfString is less than otherVersionString
		  //  0 means that selfString is equal to otherVersionString
		  // and > 0 means that selfString is greater than otherVersionString
		  
		  // may raise UnsupportedOperationException if version string are not digts & decimal points only
		  
		  // version codes should be
		  //   non-empty
		  //   composed ONLY of digits & periods
		  
		  Dim selfCodes() As String = selfString.Split(".")
		  Dim otherVersionCode() As String = otherVersionString.Split(".") 
		  
		  For i As Integer = 0 To selfcodes.Ubound
		    If selfCodes(i).IsInteger = False Then
		      #Pragma BreakOnExceptions False
		      Dim tmp As New UnsupportedOperationException
		      tmp.Message = "version comparison strings should only use digits and decimal points"
		      Raise tmp
		    End If
		  Next
		  For i As Integer = 0 To otherVersionCode.Ubound
		    If otherVersionCode(i).IsInteger = False Then
		      #Pragma BreakOnExceptions False
		      Dim tmp As New UnsupportedOperationException
		      tmp.Message = "version comparison strings should only use digits and decimal points"
		      Raise tmp
		    End If
		  Next
		  
		  // if the min is < 0 then we have something is blank and the other is not
		  // so "blank" is less than the other
		  If selfcodes.UBound < 0 And otherVersionCode.Ubound >= 0 Then
		    Return kSElfLessThanOther
		  End If
		  If selfcodes.UBound >= 0 And otherVersionCode.Ubound < 0 Then
		    Return kSelfGreaterThanOther
		  End If
		  
		  Dim minIndex As Integer = min(selfCodes.Ubound, otherVersionCode.Ubound)
		  
		  For i As Integer = 0 To minIndex
		    If Val(selfCodes(0)) < Val(otherVersionCode(0)) Then
		      Return kSelfLessThanOther
		    Elseif Val(selfCodes(0)) > Val(otherVersionCode(0)) Then
		      Return kSelfGreaterThanOther
		    Else
		      // still equal
		      // remove these parts
		      selfCodes.Remove 0
		      otherVersionCode.remove 0
		    End If
		    
		  Next
		  
		  // ok ran out of parts
		  // one of the arrays _should_ be empty by now (or they had the exact same # of exact same parts)
		  // and we know they are all nueric so the one that has more parts is "greater"
		  If selfCodes.Ubound >= 0 Then
		    Return kSelfGreaterThanOther
		  Elseif otherVersionCode.ubound >= 0 Then
		    Return kSelfLessThanOther
		  Else
		    Return kSelfEqualOther
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CompareVerionsCodes(selfString as string, otherVersionString as string) As integer
		  Return selfString.CompareVerionsCodes(otherVersionString)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Concat(paramarray vArr as variant) As string
		  Dim results() As String
		  
		  For Each v As Variant In vArr
		    
		    results.append v.StringValue
		    
		  Next
		  
		  Return Join(results, "")
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Contains(extends s As String, what As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return true if 's' contains the substring 'what'.
		  // By "contains" we mean case-insensitive, encoding-savvy containment
		  // as with InStr.
		  
		  If what = "" Then 
		    Return True
		  End If
		  
		  return InStr( s, what ) > 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Contains(charSet as string, findStr as string) As Boolean
		  return charSet.Contains(findStr)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ContainsB(extends s As String, what As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return true if 's' contains the substring 'what'.
		  // By "contains" we mean binary containment
		  // as with InStrB.
		  
		  If what = "" Then 
		    Return True
		  End If
		  
		  return InStrB( s, what ) > 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ControlCharacters() As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return the control character region of the ASCII set,
		  // i.e., ASCII 0 through 31.
		  Dim i As Integer
		  if mControlChars = "" then
		    for i = 0 to 31
		      mControlChars = mControlChars + Encodings.ASCII.Chr(i)
		    next
		  end if
		  
		  return mControlChars
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Count(source As String, substr As String) As Integer
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return how many non-overlapping occurrences of 'substr' there
		  // are in 'source'.
		  
		  dim theCount as Integer
		  dim substrLength as Integer
		  dim start as Integer
		  
		  substrLength = Len(substr)
		  If substrLength = 0 Then 
		    Return Len(source) + 1
		  End If
		  
		  start = 1
		  Do
		    start= InStr(start, source, substr)
		    If start < 1 Then 
		      Return theCount
		    End If
		    theCount = theCount + 1
		    start = start + substrLength
		  Loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CountB(source As String, substr As String) As Integer
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return how many non-overlapping occurrences of 'substr' there
		  // are in 'source', doing binary comparison.
		  
		  dim theCount as Integer
		  dim substrLength as Integer
		  dim start as Integer
		  
		  substrLength = Len(substr)
		  If substrLength = 0 Then 
		    Return LenB(source) + 1
		  End If
		  
		  start = 1
		  Do
		    start= InStrB(start, source, substr)
		    If start < 1 Then 
		      Return theCount
		    End If
		    theCount = theCount + 1
		    start = start + substrLength
		  Loop
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CountFieldsQuoted(src as string, sep as string) As Integer
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Equivalent to RB's CountFields() function, but respects quoted values
		  // Usage:
		  //    s = """Hello, Kitty"", ""One"", ""Two, Three"""
		  //    x = CountFieldsQuoted(s, ",")
		  // result: x=3
		  
		  If InStr( src, sep ) = 0 Then 
		    Return 1
		  End If
		  If InStr(src,"""")=0 Then 
		    Return CountFields(src, sep)
		  End If
		  
		  dim countParts, i, n, c as integer
		  dim sepLen as integer = len( sep )
		  dim parts( -1 ) as string
		  
		  parts = split( src, """" )
		  countParts = UBound( parts )
		  for i = 0 to countParts step 2
		    n = InStr( parts( i ), sep )
		    while n > 0
		      c = c + 1
		      n = InStr( n + sepLen, parts( i ), sep )
		    wend
		  next i
		  
		  return c + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CountRegEx(s As String, pattern As String) As Integer
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Count the number of occurrences of a RegEx pattern within a string.
		  
		  Dim out As Integer
		  
		  Dim re As New RegEx
		  Dim rm As RegExMatch
		  
		  re.SearchPattern = pattern
		  rm = re.Search( s )
		  while rm <> nil
		    out = out + 1
		    rm = re.Search
		  wend
		  
		  return out
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function DecimalSeparator() As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return the decimal separator the user uses (either "." or ",").
		  If mDecimalSeparator = "" Then
		    mDecimalSeparator = Format(1.1, "0.0")
		    mDecimalSeparator = ReplaceAll( mDecimalSeparator, "1", "" )
		  end if
		  
		  return mDecimalSeparator
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EditDistance(s1 As String, s2 As String) As Integer
		  // Return the Levenshein distance, aka the edit distance,
		  // between the two StringUtils.  That's the number of insertions,
		  // deletions, or changes required to make one string match the other.
		  // A result of 0 means the strings
		  // are identical; higher values mean more different.
		  
		  // Note that this function is case-sensitive; if you want a case-
		  // insensitive measure, simply Uppercase or Lowercase both strings
		  // before calling.
		  
		  // Implementation adapted from <http://www.merriampark.com/ld.htm>,
		  // though we're using only a 1D array since the 2D array is wasteful.
		  
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  Dim n, m As Integer
		  n = s1.Len
		  m = s2.Len
		  If n = 0 Then 
		    Return m
		  End If
		  If m = 0 Then 
		    Return n
		  End If
		  
		  Dim i, j, cost As Integer
		  Dim d(-1) As Integer
		  Redim d(m)
		  for j = 1 to m
		    d(j) = j
		  next
		  
		  Dim s1chars(-1), s2chars(-1) As String
		  s1chars = Split( s1, "" )
		  s2chars = Split( s2, "" )
		  
		  Dim s1char As String
		  Dim lastCost, nextCost As Integer
		  Dim a, b, c As Integer
		  Dim jMinus1 As Integer
		  
		  for i = 1 to n
		    s1char = s1chars(i-1)
		    lastCost = i
		    jMinus1 = 0
		    for j = 1 to m
		      If StrComp(s1char, s2chars(jMinus1),0) = 0 Then 
		        cost = 0 
		      Else 
		        cost = 1
		      End If
		      
		      // set nextCost to the minimum of the following three possibilities:
		      a = d(j) + 1
		      b = lastCost + 1
		      c = cost + d(jMinus1)
		      
		      if a < b then
		        If c < a Then 
		          nextCost = c 
		        Else 
		          nextCost = a
		        End If
		      Else
		        If c < b Then 
		          nextCost = c 
		        Else 
		          nextCost = b
		        End If
		      end if
		      
		      d(jMinus1) = lastCost
		      lastCost = nextCost
		      jMinus1 = j
		    next
		    d(m) = lastCost
		  next
		  
		  return nextCost
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EncodeBase64Properly(extends toEncodeAsBase64 as String) As string
		  return ConvertEncoding( EncodeBase64(toEncodeAsBase64), Encodings.ASCII )
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function EncodeBase64Properly(toEncodeAsBase64 as String) As string
		  return toEncodeAsBase64.EncodeBase64Properly
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Function EndsWith(extends s As String, withWhat As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return true if 's' ends with the string 'withWhat',
		  // doing a standard string comparison.
		  
		  return Right(s, withWhat.Len) = withWhat
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EndsWithB(extends s As String, withWhat As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return true if 's' ends with the string 'withWhat',
		  // doing a binary comparison.
		  
		  return StrComp( RightB(s, withWhat.Len), withWhat, 0 ) = 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ErrorIf(errCondition As Boolean, msg As String = "")
		  // Unit testing code calls this function to check if an error has
		  // occurred.  If so, report it to the user and then break into
		  // the debugger so he can do something about it.
		  
		  If Not errCondition Then 
		    Return
		  End If
		  
		  If msg = "" Then
		    msg = "Unit Test Failure :"
		  End If
		  
		  #If DebugBuild
		    //msg = msg + EndOfLine + EndOfLine _
		    //+ "Click OK to drop into the debugger and examine the stack."
		  #EndIf
		  MsgBox msg
		  
		  
		  Break  // OK, now look at the stack to see what went wrong!
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GuessEncoding(s As String) As TextEncoding
		  // from https://forum.xojo.com/t/how-to-get-unknown-encoding-of-textinputstream/21434/8
		  
		  // Guess what text encoding the text in the given string is in.
		  // This ignores the encoding set on the string, and guesses
		  // one of the following:
		  //
		  //   * UTF-32
		  //   * UTF-16
		  //   * UTF-8
		  //   * Encodings.SystemDefault
		  //
		  // Written by Joe Strout
		  
		  #Pragma DisableBackgroundTasks
		  #Pragma DisableBoundsChecking
		  
		  Static isBigEndian, endianChecked As Boolean
		  If Not endianChecked Then
		    Dim temp As String = Encodings.UTF16.Chr( &hFEFF )
		    isBigEndian = (AscB( MidB( temp, 1, 1 ) ) = &hFE)
		    endianChecked = True
		  End If
		  
		  // check for a BOM
		  Dim b0 As Integer = AscB( s.MidB( 1, 1 ) )
		  Dim b1 As Integer = AscB( s.MidB( 2, 1 ) )
		  Dim b2 As Integer = AscB( s.MidB( 3, 1 ) )
		  Dim b3 As Integer = AscB( s.MidB( 4, 1 ) )
		  If b0=0 And b1=0 And b2=&hFE And b3=&hFF Then
		    // UTF-32, big-endian
		    If isBigEndian Then
		      #If RBVersion >= 2012.02
		        Return Encodings.UTF32
		      #Else
		        Return Encodings.UCS4
		      #EndIf
		    Else
		      Return Encodings.UTF32BE
		    End If
		  ElseIf b0=&hFF And b1=&hFE And b2=0 And b3=0 And s.LenB >= 4 Then
		    // UTF-32, little-endian
		    If isBigEndian Then
		      Return Encodings.UTF32LE
		    Else
		      #If RBVersion >= 2012.02
		        Return Encodings.UTF32
		      #Else
		        Return Encodings.UCS4
		      #EndIf
		    End If
		  ElseIf b0=&hFE And b1=&hFF Then
		    // UTF-16, big-endian
		    If isBigEndian Then
		      Return Encodings.UTF16
		    Else
		      Return Encodings.UTF16BE
		    End If
		  ElseIf b0=&hFF And b1=&hFE Then
		    // UTF-16, little-endian
		    If isBigEndian Then
		      Return Encodings.UTF16LE
		    Else
		      Return Encodings.UTF16
		    End If
		  ElseIf b0=&hEF And b1=&hBB And b1=&hBF Then
		    // UTF-8 (ah, a sensible encoding where endianness doesn't matter!)
		    Return Encodings.UTF8
		  End If
		  
		  // no BOM; see if it's entirely ASCII.
		  Dim m As MemoryBlock = s
		  Dim i, maxi As Integer = s.LenB - 1
		  For i = 0 To maxi
		    If m.Byte(i) > 127 Then Exit
		  Next
		  If i > maxi Then Return Encodings.ASCII
		  
		  // Not ASCII; check for a high incidence of nulls every other byte,
		  // which suggests UTF-16 (at least in Roman text).
		  Dim nulls(1) As Integer  // null count in even (0) and odd (1) bytes
		  For i = 0 To maxi
		    If m.Byte(i) = 0 Then
		      nulls(i Mod 2) = nulls(i Mod 2) + 1
		    End If
		  Next
		  If nulls(0) > nulls(1)*2 And nulls(0) > maxi\2 Then
		    // UTF-16, big-endian
		    If isBigEndian Then
		      Return Encodings.UTF16
		    Else
		      Return Encodings.UTF16BE
		    End If
		  ElseIf nulls(1) > nulls(0)*2 And nulls(1) > maxi\2 Then
		    // UTF-16, little-endian
		    If isBigEndian Then
		      Return Encodings.UTF16LE
		    Else
		      Return Encodings.UTF16
		    End If
		  End If
		  
		  // it's not ASCII; check for illegal UTF-8 characters.
		  // See Table 3.1B, "Legal UTF-8 Byte Sequences",
		  // at <http://unicode.org/versions/corrigendum1.html>
		  Dim b As Byte
		  For i = 0 To maxi
		    Select Case m.Byte(i)
		    Case &h00 To &h7F
		      // single-byte character; just continue
		    Case &hC2 To &hDF
		      // one additional byte
		      If i+1 > maxi Then Exit For
		      b = m.Byte(i+1)
		      If b < &h80 Or b > &hBF Then Exit For
		      i = i+1
		    Case &hE0
		      // two additional bytes
		      If i+2 > maxi Then Exit For
		      b = m.Byte(i+1)
		      If b < &hA0 Or b > &hBF Then Exit For
		      b = m.Byte(i+2)
		      If b < &h80 Or b > &hBF Then Exit For
		      i = i+2
		    Case &hE1 To &hEF
		      // two additional bytes
		      If i+2 > maxi Then Exit For
		      b = m.Byte(i+1)
		      If b < &h80 Or b > &hBF Then Exit For
		      b = m.Byte(i+2)
		      If b < &h80 Or b > &hBF Then Exit For
		      i = i+2
		    Case &hF0
		      // three additional bytes
		      If i+3 > maxi Then Exit For
		      b = m.Byte(i+1)
		      If b < &h90 Or b > &hBF Then Exit For
		      b = m.Byte(i+2)
		      If b < &h80 Or b > &hBF Then Exit For
		      b = m.Byte(i+3)
		      If b < &h80 Or b > &hBF Then Exit For
		      i = i+3
		    Case &hF1 To &hF3
		      // three additional bytes
		      If i+3 > maxi Then Exit For
		      b = m.Byte(i+1)
		      If b < &h80 Or b > &hBF Then Exit For
		      b = m.Byte(i+2)
		      If b < &h80 Or b > &hBF Then Exit For
		      b = m.Byte(i+3)
		      If b < &h80 Or b > &hBF Then Exit For
		      i = i+3
		    Case &hF4
		      // three additional bytes
		      If i+3 > maxi Then Exit For
		      b = m.Byte(i+1)
		      If b < &h80 Or b > &h8F Then Exit For
		      b = m.Byte(i+2)
		      If b < &h80 Or b > &hBF Then Exit For
		      b = m.Byte(i+3)
		      If b < &h80 Or b > &hBF Then Exit For
		      i = i+3
		    Else
		      Exit For
		    End Select
		  Next i
		  If i > maxi Then Return Encodings.UTF8  // no illegal UTF-8 sequences, so that's probably what it is
		  
		  // If not valid UTF-8, then let's just guess the system default.
		  Return Encodings.SystemDefault
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Hash(s As String) As Integer
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return the hash value of the given string, as used by RB's
		  // Variant and Dictionary classes.
		  
		  Dim v As Variant
		  v = s
		  return v.Hash
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function HexB(s As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return a hex representation of each byte of s,
		  // i.e., each byte becomes a pair of hexadecimal digits,
		  // separated by spaces from the next byte.
		  
		  Dim m As MemoryBlock
		  Dim spos, mpos, bytes, b As Integer
		  
		  bytes = s.LenB
		  If bytes < 1 Then 
		    Return ""
		  End If
		  
		  Dim hexChar() As Integer = Array( _
		  48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70 )
		  
		  m = NewMemoryBlock( bytes*2 + bytes - 1 )
		  for spos = 1 to bytes
		    b = AscB( MidB( s, spos, 1 ) )
		    if b < 16 then
		      m.Byte(mpos) = hexChar(0)
		      m.Byte(mpos+1) = hexChar(b)
		    else
		      m.Byte(mpos) = hexChar(b \ 16)
		      m.Byte(mpos+1) = hexChar(b mod 16)
		    end if
		    If spos < bytes Then 
		      m.Byte(mpos+2) = 32  // space
		    End If
		    mpos = mpos + 3
		  next
		  
		  return DefineEncoding( m.StringValue(0, m.size), Encodings.ASCII )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function InStrReverse(startPos As Integer = - 1, source As String, substr As String) As Integer
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Similar to InStr, but searches backwards from the given position
		  // (or if startPos = -1, then from the end of the string).
		  // If substr can't be found, returns 0.
		  
		  Dim srcLen As Integer = source.Len
		  If startPos = -1 Then 
		    startPos = srcLen
		  End If
		  
		  // Here's an easy way...
		  // There may be a faster implementation, but then again, there may not -- it probably
		  // depends on what you're trying to do.
		  Dim reversedSource As String = Reverse(source)
		  Dim reversedSubstr As String = Reverse(substr)
		  Dim reversedPos As Integer
		  reversedPos = InStr( srcLen - startPos + 1, reversedSource, reversedSubstr )
		  If reversedPos < 1 Then 
		    Return 0
		  End If
		  return srcLen - reversedPos - substr.Len + 2
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function InStrReverseB(startPosB As Integer = - 1, source As String, substr As String) As Integer
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Similar to InStrB, but searches backwards from the given position
		  // (or if startPosB = -1, then from the end of the string).
		  // If substr can't be found, returns 0.
		  
		  Dim srcLen As Integer = source.LenB
		  Dim subLen As Integer = substr.LenB
		  If startPosB = -1 Then 
		    startPosB = srcLen
		  End If
		  
		  // We'll do a simple sequential search.  A Boyer-Moore algorithm
		  // would work better in many cases, but we'd have to rewrite the
		  // whole algorithm to work backwards.  The sequential search will
		  // be good enough in most cases anyway.
		  Dim posB As Integer
		  for posB = Min( srcLen - subLen + 1, startPosB ) downTo 1
		    If StrComp( MidB( source, posB, subLen ), substr, 0 ) = 0 Then 
		      Return posB
		    End If
		  next posB
		  
		  return 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Interpolate(extends patternString as string, paramarray vars as variant) As string
		  // String.Interpolate("Exceeds {1:####0} points", maxPoints)
		  
		  return privateInterp(patternString, vars)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Interpolate(patternString as string, paramarray vars as variant) As string
		  // String.Interpolate("Exceeds {1:####0} points", maxPoints)
		  
		  return privateInterp(patternString, vars)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDigit(extends candidate as string) As Boolean
		  // we're checking single digits
		  If Len(candidate) <> 1 Then
		    Return False
		  End If
		  
		  Return InStr("0123456789", candidate) > 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsDigit(candidate as string) As Boolean
		  Return candidate.IsDigit
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty(extends s As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return true if the string is empty.
		  
		  return s = ""
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInteger(extends s as string) As boolean
		  If s.Trim = "" Then
		    Return False
		  End If
		  
		  Dim chars() As String = s.Split("")
		  
		  For i As Integer = 0 To chars.ubound
		    If chars(i).IsDigit = False Then
		      Return False
		    End If
		  Next
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsInteger(s as string) As boolean
		  Return s.IsInteger
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LineCount(extends s as String) As integer
		  
		  Dim lines() As String = Split( ReplaceLineEndings( s, EndOfLine ), EndOfLine )
		  
		  Return lines.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LineCount(s as String) As integer
		  return s.LineCount
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LTrim(source As String, charsToTrim As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // This is an extended version of RB's LTrim function that lets you specify
		  // a set of characters to trim.
		  
		  Dim srcLen As Integer = source.Len
		  Dim leftPos, i As Integer
		  for i = 1 to srcLen
		    If InStr( charsToTrim, Mid(source, i, 1) ) = 0 Then 
		      Exit
		    End If
		  next
		  leftPos = i
		  If leftPos > srcLen Then 
		    Return ""
		  End If
		  
		  return Mid( source, leftPos )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(extends s as string, expression as string) As StringUtils.MatchPositions
		  
		  Dim rx As New RegEx
		  Dim match As RegExMatch
		  
		  rx.SearchPattern = expression
		  
		  match = rx.Search( s )
		  
		  If match Is Nil Then
		    Return StringUtils.MatchPositions.NoMatch
		  End If
		  
		  If match.SubExpressionCount > 1 Then
		    Return StringUtils.MatchPositions.Multiple
		  End If
		  
		  If match.SubExpressionStartB(0) = 0 Then
		    Return StringUtils.MatchPositions.AtStart
		  End If
		  If match.SubExpressionString(0) = s.LeftBytes( match.SubExpressionString(0).Bytes ) Then
		    Return StringUtils.MatchPositions.AtEnd
		  End If
		  
		  Return StringUtils.MatchPositions.InBetween
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Matches(s as string, expression as string) As StringUtils.MatchPositions
		  
		  
		  Return s.Matches(expression)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Metaphone(source As String, ByRef outPrimary As String, ByRef outAlternate As String)
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Compute the Double Metaphone of the source string.  This is an algorithm that
		  // finds one or two approximate phonetic representations of a string, useful in
		  // searching for almost-matches -- e.g., looking for names whose spelling may have
		  // varied, or correcting typos made by the user, and so on.
		  //
		  // The output is roughly human-readable, with the following conventions:
		  //   Vowels are omitted from the output, except for a vowel at the beginning
		  //      of a word, which is represented by an A (e.g. "ox" becomes "AKS")
		  //   X is used to represent a "ch" sound (e.g., "church" becomes "XRX")
		  //   0 (zero) is used to represent a "th" sound (e.g. "think" becomes "0NK")
		  //
		  // For more information about Double Metaphone, see:
		  //     http://aspell.sourceforge.net/metaphone/
		  //     http://www.cuj.com/articles/2000/0006/0006d/0006d.htm?topic=articles
		  //
		  // This implementation is based on the one at:
		  //     http://aspell.sourceforge.net/metaphone/dmetaph.cpp
		  
		  
		  Dim length As Integer
		  length = source.Len
		  if length < 1 then
		    outPrimary = ""
		    outAlternate = ""
		    return
		  end if
		  
		  source = Uppercase(source) + " "
		  Dim current As Integer = 1
		  
		  Dim charAt(-1) As String
		  charAt = source.Split("")
		  charAt.Insert 0, ""  // (make it 1-based, like Mid)
		  
		  Dim slavoGermanic As Boolean
		  if InStr(source, "W") > 0 or InStr(source, "K") > 0 _
		    or InStr(source, "CZ") > 0 or InStr(source, "WITZ") > 0 then
		    slavoGermanic = true
		  end if
		  
		  Dim out1, out2 As String
		  
		  // skip these when at start of word
		  If MStringAt(source, 1, 2, "GN", "KN", "PN", "WR", "PS") Then 
		    current = current + 1
		  End If
		  
		  // initial 'X' is pronounced 'Z' e.g. 'Xavier'
		  if charAt(1) = "X" then
		    out1 = out1 + "S"
		    out2 = out2 + "S"  // "Z" maps to "S"
		    current = current + 1
		  end if
		  
		  //---------- main loop ---------------
		  while current <= length
		    
		    select case charAt(current)
		      
		    case "A", "E", "I", "O", "U", "Y"
		      if current = 1 then
		        // all initial vowels map to "A"; elsewhere they're skipped
		        out1 = out1 + "A"
		        out2 = out2 + "A"
		      end if
		      current = current + 1
		      
		    case "B"
		      //"-mb", e.g", "dumb", already skipped over...
		      out1 = out1 + "P"
		      out2 = out2 + "P"
		      if charAt(current + 1) = "B" then
		        current = current + 2
		      else
		        current = current + 1
		      end if
		      
		    case "Ç"
		      out1 = out1 + "S"
		      out2 = out2 + "S"
		      current = current +  1
		      
		    case "C"
		      // various germanic
		      if current > 2 _
		        and not MIsVowel(source, current - 2) _
		        and MStringAt(source, (current - 1), 3, "ACH") _
		        and (charAt(current + 2) <> "I" and (charAt(current + 2) <> "E"_
		        or MStringAt(source, current - 2, 6, "BACHER", "MACHER")) ) then
		        out1 = out1 + "K"
		        out2 = out2 + "K"
		        current = current + 2
		        
		      elseif current = 1 AND MStringAt(source, current, 6, "CAESAR") then
		        // special case 'caesar' (why didn't this go at the top?)
		        out1 = out1 + "S"
		        out2 = out2 + "S"
		        current = current + 2
		        
		      elseif MStringAt(source, current, 4, "CHIA") then
		        // italian 'chianti'
		        out1 = out1 + "K"
		        out2 = out2 + "K"
		        current = current + 2
		        
		      elseif MStringAt(source, current, 2, "CH") then
		        // find 'michael'
		        if current > 0 AND MStringAt(source, current, 4, "CHAE") then
		          out1 = out1 + "K"
		          out2 = out2 + "X"
		          current = current + 2
		          break
		          
		        elseif current = 0 _
		          and (MStringAt(source, current + 1, 5, "HARAC", "HARIS") _
		          or MStringAt(source, current + 1, 3, "HOR", "HYM", "HIA", "HEM")) _
		          and not MStringAt(source, 0, 5, "CHORE") then
		          // greek roots e.g. 'chemistry', 'chorus'
		          out1 = out1 + "K"
		          out2 = out2 + "K"
		          current = current + 2
		          
		        else
		          //germanic, greek, or otherwise 'ch' for 'kh' sound
		          if((MStringAt(source, 0, 4, "VAN ", "VON ") or MStringAt(source, 0, 3, "SCH")) _
		            _ // 'architect but not 'arch', 'orchestra', 'orchid'
		            or MStringAt(source, current - 2, 6, "ORCHES", "ARCHIT", "ORCHID") _
		            or MStringAt(source, current + 2, 1, "T", "S") _
		            or ((MStringAt(source, current - 1, 1, "A", "O", "U", "E") OR current = 1) _
		            _ //e.g., 'wachtler', 'wechsler', but not 'tichner'
		            and MStringAt(source, current + 2, 1, "L", "R", "N", "M", "B", "H", "F", "V", "W", " "))) then
		            out1 = out1 + "K"
		            out2 = out2 + "K"
		          else
		            if current > 1 then
		              if MStringAt(source, 1, 2, "MC") then
		                //e.g., "McHugh"
		                out1 = out1 + "K"
		                out2 = out2 + "K"
		              else
		                out1 = out1 + "X"
		                out2 = out2 + "K"
		              end if
		            else
		              out1 = out1 + "X"
		              out2 = out2 + "X"
		            end if
		          end if
		          current = current + 2
		        end if
		        
		        // end of CH case
		        
		      elseif MStringAt(source, current, 2, "CZ") and not MStringAt(source, current - 2, 4, "WICZ") then
		        //e.g, 'czerny'
		        out1 = out1 + "S"
		        out2 = out2 + "X"
		        current = current +  2
		        
		      elseif MStringAt(source, current + 1, 3, "CIA") then
		        //e.g., 'focaccia'
		        out1 = out1 + "X"
		        out2 = out2 + "X"
		        current = current +  3
		        
		      elseif MStringAt(source, current, 2, "CC") and not (current = 2 AND charAt(1) = "M") then
		        // double "C", but not if e.g. 'McClellan'
		        //'bellocchio' but not 'bacchus'
		        if MStringAt(source, current + 2, 1, "I", "E", "H") and not MStringAt(source, current + 2, 2, "HU") then
		          //'accident', 'accede" "succeed'
		          if((current = 2 AND charAt(current - 1) = "A") _
		            OR MStringAt(source, current - 1, 5, "UCCEE", "UCCES")) then
		            out1 = out1 + "KS"
		            out2 = out2 + "KS"
		            //'bacci', 'bertucci', other italian
		          else
		            out1 = out1 + "X"
		            out2 = out2 + "X"
		          end if
		          current = current +  3
		        else // Pierce's rule
		          out1 = out1 + "K"
		          out2 = out2 + "K"
		          current = current +  2
		        end if
		        
		      elseif MStringAt(source, current, 2, "CK", "CG", "CQ") then
		        out1 = out1 + "K"
		        out2 = out2 + "K"
		        current = current +  2
		        
		      elseif MStringAt(source, current, 2, "CI", "CE", "CY") then
		        // italian vs. english
		        if MStringAt(source, current, 3, "CIO", "CIE", "CIA") then
		          out1 = out1 + "S"
		          out2 = out2 + "X"
		        else
		          out1 = out1 + "S"
		          out2 = out2 + "S"
		        end if
		        current = current +  2
		        
		      else
		        // all other C cases are considered a K:
		        out1 = out1 + "K"
		        out2 = out2 + "K"
		        
		        // name sent in 'mac caffrey', 'mac gregor'
		        if MStringAt(source, current + 1, 2, " C", " Q", " G" ) then
		          current = current +  3
		        else
		          if MStringAt(source, current + 1, 1, "C", "K", "Q") _
		            AND not MStringAt(source, current + 1, 2, "CE", "CI") then
		            current = current +  2
		          else
		            current = current +  1
		          end if
		        end if
		      end if
		      
		    case "D"
		      if MStringAt(source, current, 2, "DG") then
		        if MStringAt(source, current + 2, 1, "I", "E", "Y") then
		          //e.g. 'edge'
		          out1 = out1 + "J"
		          out2 = out2 + "J"
		          current = current +  3
		        else
		          //e.g. 'edgar'
		          out1 = out1 + "TK"
		          out2 = out2 + "TK"
		          current = current +  2
		        end if
		        
		      elseif MStringAt(source, current, 2, "DT", "DD") then
		        out1 = out1 + "T"
		        out2 = out2 + "T"
		        current = current +  2
		      else
		        out1 = out1 + "T"
		        out2 = out2 + "T"
		        current = current +  1
		      end if
		      
		    case "F"
		      out1 = out1 + "F"
		      out2 = out2 + "F"
		      if charAt(current + 1) = "F" then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "G"
		      if charAt(current + 1) = "H"  then
		        // GH...
		        if current > 1 AND not MIsVowel(source, current - 1) then
		          out1 = out1 + "K"
		          out2 = out2 + "K"
		          current = current +  2
		          
		        elseif current = 1 then
		          //'ghislane', ghiradelli
		          if charAt(current + 2) = "I" then
		            out1 = out1 + "J"
		            out2 = out2 + "J"
		          else
		            out1 = out1 + "K"
		            out2 = out2 + "K"
		          end if
		          current = current +  2
		          
		        elseif((current > 2 AND MStringAt(source, current - 2, 1, "B", "H", "D") ) _
		          _ //e.g., 'bough'
		          OR (current > 3 AND MStringAt(source, current - 3, 1, "B", "H", "D") ) _
		          _ //e.g., 'broughton'
		          OR (current > 4 AND MStringAt(source, current - 4, 1, "B", "H") ) ) then
		          //Parker's rule (with some further refinements) - e.g., 'hugh'
		          current = current +  2
		          
		        else
		          //e.g., 'laugh', 'McLaughlin', 'cough', 'gough', 'rough', 'tough'
		          if current > 3 _
		            AND charAt(current - 1) = "U" _
		            AND MStringAt(source, current - 3, 1, "C", "G", "L", "R", "T") then
		            out1 = out1 + "F"
		            out2 = out2 + "F"
		          else
		            if((current > 0) AND charAt(current - 1) <> "I") then
		              out1 = out1 + "K"
		              out2 = out2 + "K"
		            end if
		          end if
		          current = current +  2
		        end if
		        
		      elseif charAt(current + 1) = "N" then
		        // GN...
		        if current = 1 AND MIsVowel(source, 0) AND not SlavoGermanic then
		          out1 = out1 + "KN"
		          out2 = out2 + "N"
		        else
		          //not e.g. 'cagney'
		          if not MStringAt(source, current + 2, 2, "EY") _
		            AND charAt(current + 1) <> "Y" AND not SlavoGermanic then
		            out1 = out1 + "N"
		            out2 = out2 + "KN"
		          else
		            out1 = out1 + "KN"
		            out2 = out2 + "KN"
		          end if
		        end if
		        current = current +  2
		        
		        
		      elseif MStringAt(source, current + 1, 2, "LI") AND not SlavoGermanic then
		        //'tagliaro'
		        out1 = out1 + "KL"
		        out2 = out2 + "L"
		        current = current +  2
		        
		        
		      elseif current = 1 _
		        AND (charAt(current + 1) = "Y"  _
		        OR MStringAt(source, current + 1, 2, "ES", "EP", "EB", "EL", "EY", "IB", "IL", "IN", "IE", "EI", "ER")) then
		        //ges-,gep-,gel-, gie- at beginning
		        out1 = out1 + "K"
		        out2 = out2 + "J"
		        current = current +  2
		        
		      elseif (MStringAt(source, current + 1, 2, "ER") OR charAt(current + 1) = "Y") _
		        AND not MStringAt(source, 1, 6, "DANGER", "RANGER", "MANGER") _
		        AND not MStringAt(source, current - 1, 1, "E", "I") _
		        AND not MStringAt(source, current - 1, 3, "RGY", "OGY") then
		        // -ger-,  -gy-
		        out1 = out1 + "K"
		        out2 = out2 + "J"
		        current = current +  2
		        
		      elseif MStringAt(source, current + 1, 1, "E", "I", "Y") OR MStringAt(source, current - 1, 4, "AGGI", "OGGI") then
		        // italian e.g, 'biaggi'
		        //obvious germanic
		        if MStringAt(source, 1, 4, "VAN ", "VON ") OR MStringAt(source, 1, 3, "SCH") _
		          OR MStringAt(source, current + 1, 2, "ET") then
		          out1 = out1 + "K"
		          out2 = out2 + "K"
		        else
		          //always soft if french ending
		          if MStringAt(source, current + 1, 4, "IER ") then
		            out1 = out1 + "J"
		            out2 = out2 + "J"
		          else
		            out1 = out1 + "J"
		            out2 = out2 + "K"
		          end if
		        end if
		        current = current +  2
		        
		      else
		        // any other G
		        out1 = out1 + "K"
		        out2 = out2 + "K"
		        if charAt(current + 1) = "G" then
		          current = current +  2
		        else
		          current = current +  1
		        end if
		      end if
		      
		    case "H"
		      //only keep if first & before vowel or btw. 2 vowels
		      if (current = 1 OR MIsVowel(source, current - 1)) AND MIsVowel(source, current + 1) then
		        out1 = out1 + "H"
		        out2 = out2 + "H"
		        current = current +  2
		      else//also takes care of 'HH'
		        current = current +  1
		      end if
		      
		    case "J"
		      //obvious spanish, 'jose', 'san jacinto'
		      if MStringAt(source, current, 4, "JOSE") OR MStringAt(source, 1, 4, "SAN ") then
		        if (current = 0 AND charAt(current + 4) = " ") OR MStringAt(source, 1, 4, "SAN ") then
		          out1 = out1 + "H"
		          out2 = out2 + "H"
		        else
		          out1 = out1 + "J"
		          out2 = out2 + "H"
		        end if
		        current = current + 1
		        
		      else
		        if current = 0 AND not MStringAt(source, current, 4, "JOSE") then
		          out1 = out1 + "J"
		          out2 = out2 + "A"//Yankelovich/Jankelowicz
		        else
		          //spanish pron. of e.g. 'bajador'
		          if MIsVowel(source, current - 1) _
		            AND not SlavoGermanic _
		            AND (charAt(current + 1) = "A" OR charAt(current + 1) = "O") then
		            out1 = out1 + "J"
		            out2 = out2 + "H"
		          else
		            if current = length then
		              out1 = out1 + "J"
		              out2 = out2 + ""
		            elseif not MStringAt(source, current + 1, 1, "L", "T", "K", "S", "N", "M", "B", "Z") _
		              AND not MStringAt(source, current - 1, 1, "S", "K", "L") then
		              out1 = out1 + "J"
		              out2 = out2 + "J"
		            end if
		          end if
		        end if
		        
		        if charAt(current + 1) = "J" then //it could happen!
		          current = current +  2
		        else
		          current = current +  1
		        end if
		      end if
		      
		    case "K"
		      out1 = out1 + "K"
		      out2 = out2 + "K"
		      if charAt(current + 1) = "K" then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "L"
		      if charAt(current + 1) = "L" then
		        //spanish e.g. 'cabrillo', 'gallegos'
		        if (current = length - 2 AND MStringAt(source, current - 1, 4, "ILLO", "ILLA", "ALLE")) _
		          OR ((MStringAt(source, length - 1, 2, "AS", "OS") OR MStringAt(source, length, 1, "A", "O")) _
		          AND MStringAt(source, current - 1, 4, "ALLE")) then
		          out1 = out1 + "L"
		          out2 = out2 + ""
		          current = current +  2
		        else
		          out1 = out1 + "L"
		          out2 = out2 + "L"
		          current = current +  2
		        end if
		      else
		        out1 = out1 + "L"
		        out2 = out2 + "L"
		        current = current +  1
		      end if
		      
		    case "M"
		      out1 = out1 + "M"
		      out2 = out2 + "M"
		      if (MStringAt(source, current - 1, 3, "UMB") _
		        AND (current + 1 = length OR MStringAt(source, current + 2, 2, "ER"))) _
		        _ //'dumb","thumb'
		        OR charAt(current + 1) = "M" then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "N"
		      out1 = out1 + "N"
		      out2 = out2 + "N"
		      if charAt(current + 1) = "N" then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "Ñ"
		      out1 = out1 + "N"
		      out2 = out2 + "N"
		      current = current +  1
		      
		    case "P"
		      if charAt(current + 1) = "H" then  // PH sounds like F
		        out1 = out1 + "F"
		        out2 = out2 + "F"
		        current = current +  2
		        
		      else
		        out1 = out1 + "P"
		        out2 = out2 + "P"
		        // (also account for "campbell", "raspberry")
		        if MStringAt(source, current + 1, 1, "P", "B") then
		          current = current +  2
		        else
		          current = current +  1
		        end if
		      end if
		      
		    case "Q"
		      out1 = out1 + "K"
		      out2 = out2 + "K"
		      if charAt(current + 1) = "Q" then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "R"
		      //french e.g. 'rogier', but exclude 'hochmeier'
		      if current = length AND not SlavoGermanic _
		        AND MStringAt(source, current - 2, 2, "IE") _
		        AND not MStringAt(source, current - 4, 2, "ME", "MA") then
		        out1 = out1 + ""
		        out2 = out2 + "R"
		      else
		        out1 = out1 + "R"
		        out2 = out2 + "R"
		      end if
		      
		      if charAt(current + 1) = "R" then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "S"
		      if MStringAt(source, current - 1, 3, "ISL", "YSL") then
		        //special cases 'island', 'isle', 'carlisle', 'carlysle'
		        current = current +  1
		        
		      elseif current = 1 AND MStringAt(source, current, 5, "SUGAR") then
		        //special case 'sugar-'
		        out1 = out1 + "X"
		        out2 = out2 + "S"
		        current = current +  1
		        
		      elseif MStringAt(source, current, 2, "SH") then
		        //germanic
		        if MStringAt(source, current + 1, 4, "HEIM", "HOEK", "HOLM", "HOLZ") then
		          out1 = out1 + "S"
		          out2 = out2 + "S"
		        else
		          out1 = out1 + "X"
		          out2 = out2 + "X"
		        end if
		        current = current +  2
		        
		      elseif MStringAt(source, current, 3, "SIO", "SIA") OR MStringAt(source, current, 4, "SIAN") then
		        //italian & armenian
		        if not SlavoGermanic then
		          out1 = out1 + "S"
		          out2 = out2 + "X"
		        else
		          out1 = out1 + "S"
		          out2 = out2 + "S"
		        end if
		        current = current +  3
		        
		      elseif (current = 1 AND MStringAt(source, current + 1, 1, "M", "N", "L", "W")) _
		        OR MStringAt(source, current + 1, 1, "Z") then
		        //german & anglicisations, e.g. 'smith' match 'schmidt', 'snider' match 'schneider'
		        //also, -sz- in slavic language altho in hungarian it is pronounced "s"
		        out1 = out1 + "S"
		        out2 = out2 + "X"
		        if MStringAt(source, current + 1, 1, "Z") then
		          current = current +  2
		        else
		          current = current +  1
		        end if
		        
		      elseif MStringAt(source, current, 2, "SC") then
		        //Schlesinger's rule
		        if charAt(current + 2) = "H" then
		          //dutch origin, e.g. 'school', 'schooner'
		          if MStringAt(source, current + 3, 2, "OO", "ER", "EN", "UY", "ED", "EM") then
		            //'schermerhorn', 'schenker'
		            if MStringAt(source, current + 3, 2, "ER", "EN") then
		              out1 = out1 + "X"
		              out2 = out2 + "SK"
		            else
		              out1 = out1 + "SK"
		              out2 = out2 + "SK"
		            end if
		            current = current +  3
		            
		          else
		            if current = 1 AND not MIsVowel(source, 4) AND charAt(4) <> "W" then
		              out1 = out1 + "X"
		              out2 = out2 + "S"
		            else
		              out1 = out1 + "X"
		              out2 = out2 + "X"
		            end if
		            current = current +  3
		          end if
		          
		        elseif MStringAt(source, current + 2, 1, "I", "E", "Y") then
		          out1 = out1 + "S"
		          out2 = out2 + "S"
		          current = current +  3
		          
		        else
		          out1 = out1 + "SK"
		          out2 = out2 + "SK"
		          current = current +  3
		        end if
		        
		      else
		        //french e.g. 'resnais', 'artois'
		        if current = length AND MStringAt(source, current - 2, 2, "AI", "OI") then
		          out1 = out1 + ""
		          out2 = out2 + "S"
		        else
		          out1 = out1 + "S"
		          out2 = out2 + "S"
		        end if
		        if MStringAt(source, current + 1, 1, "S", "Z") then
		          current = current +  2
		        else
		          current = current +  1
		        end if
		      end if
		      
		    case "T"
		      if MStringAt(source, current, 4, "TION") then
		        out1 = out1 + "X"
		        out2 = out2 + "X"
		        current = current +  3
		        
		      elseif MStringAt(source, current, 3, "TIA", "TCH") then
		        out1 = out1 + "X"
		        out2 = out2 + "X"
		        current = current +  3
		        
		      elseif MStringAt(source, current, 2, "TH") OR MStringAt(source, current, 3, "TTH") then
		        //special case 'thomas', 'thames' or germanic
		        if MStringAt(source, current + 2, 2, "OM", "AM") _
		          OR MStringAt(source, 1, 4, "VAN ", "VON ") OR MStringAt(source, 1, 3, "SCH") then
		          out1 = out1 + "T"
		          out2 = out2 + "T"
		        else
		          out1 = out1 + "0"     // 0 represents "TH" sound in Metaphone
		          out2 = out2 + "T"     // (a bad choice -- # would have been better)
		        end if
		        current = current +  2
		        
		      else
		        out1 = out1 + "T"
		        out2 = out2 + "T"
		        if MStringAt(source, current + 1, 1, "T", "D") then
		          current = current +  2
		        else
		          current = current +  1
		        end if
		      end if
		      
		    case "V"
		      out1 = out1 + "F"
		      out2 = out2 + "F"
		      if charAt(current + 1) = "V" then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "W"
		      //can also be in middle of word
		      if MStringAt(source, current, 2, "WR") then
		        out1 = out1 + "R"
		        out2 = out2 + "R"
		        current = current +  2
		        
		      else
		        if current = 1 AND (MIsVowel(source, current + 1) OR MStringAt(source, current, 2, "WH")) then
		          //Wasserman should match Vasserman
		          if(MIsVowel(source, current + 1)) then
		            out1 = out1 + "A"
		            out2 = out2 + "F"
		          else
		            //need Uomo to match Womo
		            out1 = out1 + "A"
		            out2 = out2 + "A"
		          end if
		        end if
		        
		        if (current = length AND MIsVowel(source, current - 1)) _
		          OR MStringAt(source, current - 1, 5, "EWSKI", "EWSKY", "OWSKI", "OWSKY") _
		          OR MStringAt(source, 1, 3, "SCH") then
		          //Arnow should match Arnoff
		          out1 = out1 + ""
		          out2 = out2 + "F"
		          current = current + 1
		          
		        elseif MStringAt(source, current, 4, "WICZ", "WITZ") then
		          //polish e.g. 'filipowicz'
		          out1 = out1 + "TS"
		          out2 = out2 + "FX"
		          current = current + 4
		          
		        else
		          //else skip it
		          current = current + 1
		        end if
		      end if
		      
		    case "X"
		      //french e.g. breaux
		      if not (current = length AND _
		        (MStringAt(source, current - 3, 3, "IAU", "EAU") OR MStringAt(source, current - 2, 2, "AU", "OU"))) then
		        out1 = out1 + "KS"
		        out2 = out2 + "KS"
		      end if
		      
		      if MStringAt(source, current + 1, 1, "C", "X") then
		        current = current +  2
		      else
		        current = current +  1
		      end if
		      
		    case "Z"
		      //chinese pinyin e.g. 'zhao'
		      if charAt(current + 1) = "H" then
		        out1 = out1 + "J"
		        out2 = out2 + "J"
		        current = current +  2
		        
		      else
		        if MStringAt(source, current + 1, 2, "ZO", "ZI", "ZA") _
		          OR (SlavoGermanic AND current > 1 AND charAt(current - 1) <> "T") then
		          out1 = out1 + "S"
		          out2 = out2 + "TS"
		        else
		          out1 = out1 + "S"
		          out2 = out2 + "S"
		        end if
		        
		        if charAt(current + 1) = "Z" then
		          current = current +  2
		        else
		          current = current +  1
		        end if
		      end if
		      
		      // ----
		    else
		      // if none of the above cases, just skip this character
		      current = current + 1
		    end Select
		  wend
		  
		  outPrimary = out1
		  outAlternate = out2
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MIsVowel(source As String, atPos As Integer) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // This is a private helper function for the Metaphone method.
		  
		  return InStr( "AEIOUY", Mid(source, atPos, 1) ) > 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MStringAt(source As String, start As Integer, length As Integer, paramArray args As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // This is a private helper function for the Metaphone method.
		  
		  If start < 1 Then 
		    Return False
		  End If
		  Dim target As String
		  if start > source.Len then
		    target = " "
		  else
		    target = Mid(source, start, length)
		  end if
		  return (args.IndexOf(target) >= 0)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NormalizeString(originalString as string, normalizationForm as integer = kCFStringNormalizationFormD) As string
		  #If targetMacOS
		    Soft Declare Function CFStringCreateMutableCopy Lib "Foundation" (alloc As Ptr, maxLength As UInt32, theString As CFStringRef) As CFStringRef
		    
		    Dim mutableStringRef As CFStringRef = CFStringCreateMutableCopy(Nil, 0, originalString)
		    
		    Soft Declare Sub CFStringNormalize Lib "Foundation" (theString As CFStringRef, theForm As UInt32)
		    
		    CFStringNormalize mutableStringRef, normalizationForm
		    Return mutableStringRef
		  #Else
		    Return originalString
		  #EndIf
		  
		  'enum CFStringNormalizationForm {
		  'kCFStringNormalizationFormD = 0,
		  'kCFStringNormalizationFormKD = 1,
		  'kCFStringNormalizationFormC = 2,
		  'kCFStringNormalizationFormKC = 3
		  // 
		  // where “s” Is the String And “form” Is UInt32
		  // 
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function NthFieldQuoted(src as string, sep as string, index as integer) As string
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Equivalent to RB's nthField() function, but respects quoted values
		  // Usage:
		  //    s = """Hello, Kitty"", ""One"", ""Two, Three"""
		  //    s1 = nthFieldQuoted(s, ",", 3)
		  // result: s1 = "Two, Three" (including the quotes!)
		  
		  dim c, n, startPos, endPos as integer
		  dim inQuotes as boolean
		  dim a as string
		  
		  dim sepLen as integer = sep.Len
		  dim srcLen as integer = len( src )
		  dim leftSep as string = left( sep, 1 )
		  dim adjustedIndex as integer = (index -1)
		  
		  if InStr(src,sep)=0 then
		    if index=1 then
		      return src
		    else
		      return ""
		    end if
		  elseif InStr(src,"""")= 0 then
		    return NthField(src, sep, index)
		  end if
		  
		  for n=1 to srcLen
		    a = Mid(src,n,1)
		    if a= """" then
		      inQuotes = not inQuotes
		    elseif (a=leftSep) and not inQuotes then
		      if mid(src, n, sepLen) = sep then
		        c = c + 1
		        if index = 1 then
		          // First Field
		          startPos = 1
		          endPos = n-1
		          exit
		        else
		          // Field 2..x
		          if (c=adjustedIndex)  then
		            // Leading Sep gefunden
		            startPos = n+sepLen
		          elseif (c = index) then
		            // Trailing Sep found
		            endPos = n-1
		            exit
		          end if
		        end if
		      end if
		    end if
		  next
		  if endpos = 0 then
		    endpos = srcLen + 1
		  end if
		  
		  if startPos = 0 then
		    if index=1 then
		      return src
		    else
		      return ""
		    end if
		  else
		    return mid(src,startPos,endPos-startPos+1)
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PadBoth(s as String, width as Integer, padding as String = " ") As string
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Pad a string to at least 'width' characters, by adding padding characters
		  // to the left and right sides of the string.
		  //
		  // If it is impossible to center the string, the string will be one character
		  // to the right more than it is to the left.
		  
		  dim length as Integer
		  
		  length = len(s)
		  If length >= width Then 
		    Return s
		  End If
		  
		  dim mostToRepeat as Integer
		  mostToRepeat = ceil((width-length)/len(padding))
		  
		  dim repeated as String
		  repeated = Repeat(padding, ceil(mostToRepeat/2))
		  
		  return mid(repeated, 1, ceil((width-length)/2)) + s + mid(repeated,1,(width-length)\2)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PadLeft(s as String, width as Integer, padding as String = " ") As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Pad a string to at least 'width' characters, by adding padding characters
		  // to the left side of the string.
		  
		  dim length as Integer
		  length = len(s)
		  If length >= width Then 
		    Return s
		  End If
		  
		  dim mostToRepeat as Integer
		  mostToRepeat = ceil((width-length)/len(padding))
		  return mid(Repeat(padding, mostToRepeat),1,width-length) + s
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PadRight(s as String, width as Integer, padding as String = " ") As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Pad a string to at least 'width' characters, by adding padding characters
		  // to the right side of the string.
		  
		  dim length as Integer
		  length = len(s)
		  If length >= width Then 
		    Return s
		  End If
		  
		  dim mostToRepeat as Integer
		  mostToRepeat = ceil((width-length)/len(padding))
		  return s + mid(Repeat(padding, mostToRepeat),1,width-length)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParamStr(extends baseString as string, replacements() as string) As string
		  // takes a string like 
		  // foo %1 %2 and %3
		  // and will replace the %1 with the first param, %2 with the second, and so on
		  // you can use the same %N marker as many times as you want
		  
		  Dim workingCopy As String = baseString
		  Dim r As New Random
		  
		  Dim marker As String = ChrB(0)
		  
		  Dim reconsiderMarkers As Boolean
		  
		  Do
		    reconsiderMarkers  = False
		    
		    For n As Integer = 0 To replacements.ubound
		      If replacements(n).InStr( marker ) > 0 Then
		        reconsiderMarkers = True
		        Exit For
		      End If
		    Next
		    
		    If reconsiderMarkers Then
		      marker = marker + Encodings.UTF8.Chr(r.InRange(0,10))
		    End If
		    
		  Loop Until reconsiderMarkers = False
		  
		  
		  For n As Integer = 0 To replacements.ubound
		    // ok we need to avoid the case where you replace 
		    // %1 with %2 and then replace %2 with something else
		    // and the %2 we inserted as a replacement for %1 is replaced by something else
		    // or do we care about this ?
		    
		    // so first we replace all the %N markers with chrb(0)+N+chrb(0)
		    // yes this still could be subverted IF a person knew the innards
		    
		    workingCopy = workingCopy.ReplaceAll("%"+Str(n+1), marker + Str(n+1) + marker )
		    
		  Next
		  
		  For n As Integer = 0 To replacements.ubound
		    
		    workingCopy = workingCopy.ReplaceAll( marker + Str(n+1) + marker , replacements(n) )
		    
		  Next
		  
		  workingCopy = DefineEncoding(workingCopy, baseString.Encoding)
		  
		  Return workingCopy
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParamStr(extends baseString as string, ParamArray replacements as string) As string
		  Return baseString.ParamStr(replacements)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParamStr(baseString as string, ParamArray replacements as string) As string
		  Return baseString.ParamStr(replacements)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function privateInterp(patternstring as string, vars() as Variant) As string
		  
		  
		  // ok we find all the chunks mared as {###[:format pattern]}
		  // replace each of them with a suitably formahted value
		  //     there _may_ not be one so it gets left untouched
		  // put the entire mess back together
		  // and return the resulting string
		  
		  Dim chunks() As String = chunkify(patternString)
		  
		  For i As Integer = 0 To chunks.ubound
		    // ok so formats are
		    //    { number : format str }
		    //  numbers are 0 based for "first param" (0)
		    //  format strings ESP for numeric values are the same as the FORMAT command
		    //
		    // see https://unicode-org.github.io/icu/userguide/format_parse/datetime/#formatting-dates
		    //  format strings for date / date time can be (NOTE THESE ARE CASE SENSITIVE !)
		    //               - a locale name ?
		    //               - short|medium|long : sort|medium|long (date & time)
		    //               - YY   - 2 digit year
		    //               - YYYY - 4 digit year
		    //               - M    - month # (not zero filled)
		    //               - MM   - 2 digit month # 
		    //               - MMM  - month name (not sure about this one)
		    //               - d    - day # not zero filled
		    //               - dd   - 2 digit day # 
		    //               - DD   - day # of the year
		    //               - h    - hour (not zero filled)
		    //               - hh   - hour (zero filled)
		    //               - H    - hour 0 - 24 (not zero filled)
		    //               - HH   - hour 0 - 24 (zero filled)
		    //               - m    - minute (not zero filled)
		    //               - mm   - minute (zero filled)
		    //               - s    - second (not zero filled)
		    //               - ss   - second (zero filled)
		    //               - a - am pm
		    
		    Dim working As String = chunks(i)
		    If working.BeginsWith("{") And working.EndsWith("}") Then
		      // ok rip off the leading and trailing { and } 
		      //    - they _could_ exist in a pattern string - unlikely but possible
		      Dim interpMarkerContent As String = working.Mid(2, working.Len - 2)
		      
		      Dim varNumStr As String = NthField(interpMarkerContent,":", 1)
		      Dim fmtStr As String = NthField(interpMarkerContent,":", 2)
		      
		      Dim varNum As Integer = Val(varNumStr)
		      If varNum >= 1 And varNum <= vars.ubound+1 Then
		        
		        Dim variable As Variant = vars(varNum-1)
		        
		        Select Case variable.Type
		        Case Variant.TypeBoolean
		          chunks(i) = variable.BooleanValue.ToString
		          
		        Case Variant.TypeColor
		          chunks(i) = ToProperColorString(variable.ColorValue)
		          
		        Case Variant.TypeCString
		          chunks(i) = variable.CStringValue
		          
		        Case Variant.TypeCurrency
		          If Trim(fmtStr) = "" Then
		            fmtStr = "-#######0.0000"
		          End If
		          chunks(i) = Format(variable.CurrencyValue, fmtStr)
		          
		        Case Variant.TypeDate
		          If Trim(fmtStr) = "" Then
		            chunks(i) = date(variable).SQLDateTime
		          Else
		            Dim secondsSince1970 As Double 
		            Dim dt1970 As New Date(1970,01,01,0,0,0)
		            secondsSince1970 = variable.DateValue.TotalSeconds - dt1970.TotalSeconds
		            Dim dt As New DateTime( secondsSince1970, Nil)
		            chunks(i) = dt.ToString( fmtStr, Nil )
		          End If
		          
		        Case Variant.TypeDateTime
		          If Trim(fmtStr) = "" Then
		            chunks(i) = DateTime(variable).SQLDateTime
		          Else
		            chunks(i) = variable.DateTimeValue.ToString( fmtStr, Nil )
		          End If
		          
		        Case Variant.TypeDouble
		          If Trim(fmtStr) = "" Then
		            fmtStr = "-#######0.0000"
		          End If
		          chunks(i) = Format(variable.DoubleValue, fmtStr)
		          
		        Case Variant.TypeInt32
		          If Trim(fmtStr) = "" Then
		            fmtStr = "-#######0"
		          End If
		          chunks(i) = Format(variable.Int32Value, fmtStr)
		          
		        Case Variant.TypeInt64
		          If Trim(fmtStr) = "" Then
		            fmtStr = "-#######0"
		          End If
		          chunks(i) = Format(variable.Int64Value, fmtStr)
		          
		        Case Variant.TypeInteger
		          If Trim(fmtStr) = "" Then
		            fmtStr = "-#######0"
		          End If
		          chunks(i) = Format(variable.IntegerValue, fmtStr)
		          
		        Case Variant.TypeNil
		          Break
		          
		        Case Variant.TypeSingle
		          If Trim(fmtStr) = "" Then
		            fmtStr = "-#######0.0000"
		          End If
		          chunks(i) = Format(variable.SingleValue, fmtStr)
		          
		        Case Variant.TypeString
		          chunks(i) = variable.StringValue
		          
		        Else
		          Break
		        End select
		        
		      End If
		    End If
		    
		  Next
		  
		  Return Join(chunks, "")
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Remove(s As String, charSet As String = " ") As string
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Delete all characters which are members of charSet. Example:
		  // Delete("wooow maaan", "aeiou") = "ww mn".
		  
		  Dim sLen As Integer = s.Len
		  If sLen < 2 Then 
		    Return s
		  End If
		  
		  Dim m As MemoryBlock
		  m = NewMemoryBlock( sLen )
		  
		  charSet = ConvertEncoding( charSet, s.Encoding )
		  
		  Dim char As String
		  Dim spos, mpos As Integer
		  For spos = 1 To sLen
		    char = Mid( s, spos, 1 )
		    If InStr( charSet, char ) < 1 Then
		      m.StringValue( mpos, char.Len ) = char
		      mpos = mpos + char.Len
		    End If
		  Next
		  
		  return DefineEncoding( m.StringValue(0, mpos), s.Encoding )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Repeat(s as String, repeatCount as Integer) As string
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Concatenate a string to itself 'repeatCount' times.
		  // Example: Repeat("spam ", 5) = "spam spam spam spam spam ".
		  
		  #Pragma disablebackgroundTasks
		  
		  If repeatCount <= 0 Then Return ""
		  If repeatCount = 1 Then Return s
		  
		  // Implementation note: normally, you don't want to use string concatenation
		  // for something like this, since that creates a new string on each operation.
		  // But in this case, we can double the size of the string on iteration, which
		  // quickly reduces the overhead of concatenation to insignificance.  This method
		  // is faster than any other we've found (short of declares, which were only
		  // about 2X faster and were quite platform-specific).
		  
		  Dim desiredLenB As Integer = LenB(s) * repeatCount
		  Dim output As String = s
		  Dim cutoff As Integer = (desiredLenB+1)\2
		  Dim curLenB As Integer = LenB(output)
		  
		  While curLenB < cutoff
		    output = output + output
		    curLenB = curLenB + curLenB
		  Wend
		  
		  output = output + LeftB(output, desiredLenB - curLenB)
		  Return output
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReplaceLast(content as string, findStr as string, replaceWith as String) As string
		  
		  // reverse the String
		  Dim reversedContent As String = Reverse(content)
		  // reverse the pattern 
		  dim reversedPattern as string = Reverse(findStr)
		  // now see If the String now starts With the reverse pattern
		  
		  If reversedContent.StartsWith(reversedPattern) Then
		    // if so replace it with the revsed replacement
		    Dim reversedReplacement As String = reverse(replaceWith)
		    
		    Dim reversedResult As String = reversedContent.Replace(reversedPattern, reversedReplacement)
		    
		    // then reverse & return the result
		    
		    Return reverse(reversedResult)
		    
		  Else
		    
		    Return content
		    
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReplaceRange(s As String, start As Integer, length As Integer, newText As String) As string
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Replace a part of the given string with a new string.
		  
		  return Left(s, start-1) + newText + Mid(s, start + length)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReplaceRangeB(s As String, startB As Integer, lengthB As Integer, newText As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Replace a part of the given string with a new string
		  // (with offset and length in bytes rather than characters).
		  
		  return LeftB(s, startB-1) + newText + MidB(s, startB + lengthB)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Reverse(s As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return s with the characters in reverse order.
		  If Len(s) < 2 Then 
		    Return s
		  End If
		  
		  dim oldEncoding as TextEncoding
		  oldEncoding = s.Encoding
		  
		  s = ConvertEncoding( s, Encodings.UTF16 )
		  
		  Dim m As MemoryBlock
		  Dim c As String
		  Dim pos, mpos, csize As Integer
		  
		  m = NewMemoryBlock( s.LenB )
		  
		  pos = 1
		  mpos = m.Size
		  while mpos > 0
		    c = Mid( s, pos, 1 )
		    csize = c.LenB
		    mpos = mpos - csize
		    m.StringValue( mpos, csize ) = c
		    pos = pos + 1
		  wend
		  
		  return DefineEncoding( m.StringValue(0, m.Size), s.Encoding )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ReverseB(s As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return s with the bytes in reverse order.
		  // Note that if s is text in any encoding that may have
		  // multi-byte characters, you should probably be using
		  // Reverse instead of ReverseB.
		  
		  If LenB(s) < 2 Then 
		    Return s
		  End If
		  
		  Dim m As MemoryBlock
		  Dim pos, bytes As Integer
		  bytes = s.LenB
		  
		  m = NewMemoryBlock( bytes )
		  
		  for pos = bytes - 1 DownTo 0
		    m.Byte(pos) = AscB( s.MidB( bytes - pos, 1 ) )
		  next
		  
		  return DefineEncoding( m.StringValue(0, bytes), s.Encoding )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RTrim(source As String, charsToTrim As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // This is an extended version of RB's RTrim function that lets you specify
		  // a set of characters to trim.
		  
		  Dim srcLen As Integer = source.Len
		  Dim rightPos, i As Integer
		  for i = srcLen DownTo 1
		    If InStr( charsToTrim, Mid(source, i, 1) ) = 0 Then 
		      Exit
		    End If
		  next
		  rightPos = i
		  
		  return Mid( source, 1, rightPos )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RunUnitTests()
		  #If debugbuild
		    
		    Dim Logger As debug.logger = CurrentMethodName
		    
		    If True Then
		      
		      Debug.Assert Concat( "123", 456, 7.5 ) = "1234567.5", "concat failed"
		      
		      Debug.Assert Concat( "123", Nil, 7.5 ) = "1237.5", "concat failed"
		      
		      Dim d As DateTime = New DateTime(2023,03,18,11,16,38,0, New TimeZone(-7*60*60) ) // MDT
		      
		      Debug.Assert Concat( "123", d, 7.5 ) = "1232023-03-18 11:16:387.5", "concat failed"
		      
		    End If
		    
		    // should work
		    If True Then
		      dim pattern as string = "%1"
		      
		      dim result as string = pattern.ParamStr("foo")
		      
		      Debug.assert result = "foo", CurrentMethodName + " did not get the result expected"
		      Debug.assert result.Encoding = pattern.Encoding, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim pattern As String = "%1%2"
		      
		      Dim result As String = pattern.ParamStr("%2", "bar")
		      
		      Debug.assert result = "%2bar", CurrentMethodName + " did not get the result expected"
		      Debug.assert result.Encoding = pattern.Encoding, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim pattern As String = "%1%2"
		      
		      Dim result As String = pattern.ParamStr(Chr(0), Chr(0)+Chr(1)+"bar")
		      
		      Debug.assert result = Chr(0)+Chr(0)+Chr(1)+"bar", CurrentMethodName + " did not get the result expected"
		      Debug.assert result.Encoding = pattern.Encoding, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim pattern As String = "%1%2"
		      
		      Dim result As String = pattern.ParamStr("%2","%3")
		      
		      Debug.assert result = "%2%3", CurrentMethodName + " did not get the result expected"
		      Debug.assert result.Encoding = pattern.Encoding, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim pattern As String = "%1%2"
		      
		      Dim result As String = pattern.ParamStr("%2","%3")
		      
		      Debug.assert result = "%2%3", CurrentMethodName + " did not get the result expected"
		      Debug.assert result.Encoding = pattern.Encoding, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    /// ========================
		    // should work
		    If True Then
		      Dim versionOne As String
		      Dim versionTwo As String = "1"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be < version 2
		        Debug.assert result < 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert False , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		    End If
		    
		    If True Then
		      Dim versionOne As String = "1"
		      Dim versionTwo As String 
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be > version 2
		        Debug.assert result > 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert False , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		    End If
		    
		    // should raise an exception
		    If True Then
		      Dim versionOne As String = "a"
		      Dim versionTwo As String = "1"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        
		        debug.assert False, CurrentMethodName + " expected to get an exceptio but didnt"
		        // version 1 should be < version 2
		        Debug.assert result < 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        // this is correct as versionOne is not conformant to the digits.digits.digits form
		      End Try
		      
		    End If
		    
		    // should raise an exception
		    If True Then
		      Dim versionOne As String = "1"
		      Dim versionTwo As String = "a"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        
		        debug.assert False, CurrentMethodName + " expected to get an exceptio but didnt"
		        // version 1 should be < version 2
		        Debug.assert result < 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        // this is correct as versionOne is not conformant to the digits.digits.digits form
		      End Try
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim versionOne As String = "1.1.1"
		      Dim versionTwo As String = "1.1.1"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be = version 2
		        Debug.assert result = 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert False , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim versionOne As String = "1.1"
		      Dim versionTwo As String = "1"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be > version 2
		        Debug.assert result = 1, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert False , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim versionOne As String = "1"
		      Dim versionTwo As String = "1.1"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be < version 2
		        Debug.assert result < 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert False , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim versionOne As String = "1.1"
		      Dim versionTwo As String = "1.2"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be < version 2
		        Debug.assert result < 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert False , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		    End If
		    
		    // should work
		    If True Then
		      Dim versionOne As String = "1.2"
		      Dim versionTwo As String = "1.1"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be > version 2
		        Debug.assert result > 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert False , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		    End If
		    
		    // should work regardless of the length of the string (thanks Sun !)
		    If True Then
		      Dim versionOne As String = "1.1.1.1.1.1.1.1"
		      Dim versionTwo As String = "1.1.1.1.1.1.1.1"
		      
		      Dim result As Integer 
		      Try
		        result = versionOne.CompareVerionsCodes(versionTwo)
		        // version 1 should be = version 2
		        Debug.assert result = 0, CurrentMethodName + " did not get the result expected"
		        
		      Catch uso As UnsupportedOperationException
		        Debug.assert false , CurrentMethodName + " got unexpected exception"
		      End Try
		      
		    End If
		    
		    //
		    If True Then
		      Dim x1, y1, x2, y2 As Integer
		      x1 = 1
		      y1 = 2
		      x2 = 3
		      y2 = 4
		      
		      Dim result As String = Interpolate("{1:##0} {2:##0} - {3:##0} {4:##0} ", X1,Y1,X2,Y2)
		      
		      Debug.assert result = "1 2 - 3 4 ", CurrentMethodName + " did not get the result expected"
		      Debug.assert result.Encoding = Encodings.UTF8, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    If True Then
		      Dim x1, y1, x2, y2 As Integer
		      x1 = 1
		      y1 = 2
		      x2 = 3
		      y2 = 4
		      
		      Dim result As String = Interpolate("{1} {2} - {3} {4}", X1,Y1,X2,Y2)
		      
		      Debug.assert result = "1 2 - 3 4", CurrentMethodName + " did not get the result expected"
		      Debug.assert result.Encoding = Encodings.UTF8, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    If True Then
		      Dim c1 As Currency
		      Dim d1 As New Date(2024,12,31,12,43,56)
		      Dim d2 As New DateTime(2024,12,31,12,43,56)
		      Dim dbl1 As Double
		      Dim i32 As Int32
		      Dim i64 As Int64
		      Dim i As Integer
		      Dim s1 As Single
		      
		      Dim result As String = Interpolate("{1} {2} {3} {4} {5} {6} {7} {8}", c1,d1,d2,dbl1,i32,i64,i,s1)
		      
		      Debug.assert result = "0.0000 2024-12-31 12:43:56 2024-12-31 12:43:56 0.0000 0 0 0 0.0000", CurrentMethodName + " did not get the result expected"
		      
		      Debug.assert result.Encoding = Encodings.UTF8, CurrentMethodName + " did not get the same encoding"
		      
		    End If
		    
		    //======================================================
		    //======================================================
		    //======================================================
		    //======================================================
		    //
		    If True Then
		      Dim start As String
		      Dim result As String = EncodeBase64Properly( "123456" )
		      
		      Debug.assert result.Encoding = Encodings.ASCII, "Encoding SHOULD BE ASCII !"
		      Debug.assert result = "MTIzNDU2", "Didnt base 64 encode properly"
		      
		    End If
		    
		  #EndIf
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Soundex(s As String, stripPrefix As Boolean = true) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return the Soundex code for the given string.
		  // That's the first character, followed by numeric
		  // codes for the first several consonants.
		  // For more detail, see: <http://www.searchforancestors.com/soundex.html>
		  
		  Dim prefix, prefixes(-1) As String
		  Dim i, prefixLen As Integer
		  
		  s = Trim( s )
		  
		  if stripPrefix then
		    prefixes = Array("La ", "De ", "Van ")  // more to come?
		    for each prefix in prefixes
		      prefixLen = prefix.Len
		      if Left( s, prefixLen ) = prefix then
		        s = Mid( s, prefixLen+1 )
		        exit
		      end if
		    next
		  end if
		  
		  Dim c, out As String
		  out = Uppercase( Left(s, 1) )
		  Dim sLen, curCode, lastCode As Integer
		  sLen = s.Len
		  for i = 2 to sLen
		    c = Uppercase( Mid( s, i, 1 ) )
		    if InStrB( "BPFV", c ) > 0 then
		      curCode = 1
		    elseif InStrB( "CSKGJQXZ", c ) > 0 then
		      curCode = 2
		    elseif InStrB( "DT", c ) > 0 then
		      curCode = 3
		    elseif c = "L" then
		      curCode = 4
		    elseif InStrB( "MN", c ) > 0 then
		      curCode = 5
		    elseif c = "R" then
		      curCode = 6
		    else
		      curCode = 0
		    end if
		    if curCode > 0 and curCode <> lastCode then
		      out = out + str(curCode)
		      If Len(out) = 4 Then 
		        Return out
		      End If
		    end if
		  next
		  
		  return Left( out + "000", 4 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SplitByLength(s As String, fieldWidth As Integer) As String()
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Split a string into fields, each containing 'fieldWidth' characters
		  // (except for the last one, which may have fewer).
		  
		  if fieldWidth < 1 then   // fieldWidth must be >= 1
		    raise New OutOfBoundsException
		  end if
		  
		  Dim out(-1) As String
		  
		  Dim qty As Integer
		  qty = Ceil( Len(s) / fieldWidth )
		  Redim out( qty - 1 )
		  
		  Dim pos, i As Integer
		  pos = 1
		  for i = 0 to qty-1
		    out(i) = Mid( s, pos, fieldWidth )
		    pos = pos + fieldWidth
		  next
		  
		  return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SplitByLengthB(s As String, fieldWidth As Integer) As String()
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Split a string into fields, each containing 'fieldWidth' bytes
		  // (except for the last one, which may have fewer).
		  
		  if fieldWidth < 1 then   // fieldWidth must be >= 1
		    raise New OutOfBoundsException
		  end if
		  
		  Dim out(-1) As String
		  
		  Dim qty As Integer
		  qty = Ceil( LenB(s) / fieldWidth )
		  Redim out( qty - 1 )
		  
		  Dim pos, i As Integer
		  pos = 1
		  for i = 0 to qty-1
		    out(i) = MidB( s, pos, fieldWidth )
		    pos = pos + fieldWidth
		  next
		  
		  return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SplitByRegEx(source As String, delimPattern As String) As String()
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Split a string into fields delimited by a regular expression.
		  
		  Dim out(-1) As String
		  
		  Dim re As New RegEx
		  Dim rm As RegExMatch
		  Dim startPos As Integer
		  
		  re.SearchPattern = delimPattern
		  rm = re.Search( source )
		  while rm <> nil
		    out.Append MidB( source, startPos + 1, rm.SubExpressionStartB(0) - startPos )
		    startPos = re.SearchStartPosition
		    rm = re.Search
		  wend
		  
		  if startPos < source.LenB then
		    out.Append MidB( source, startPos + 1 )
		  end if
		  
		  return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SplitToCDbl(source As String, delimiter As String = " ") As Double()
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Split a string into fields, then convert each field into a Double
		  // using the CDbl function.  This is appropriate for a set of numbers
		  // entered or readable by the end-user.
		  
		  Dim fields(-1) As String
		  fields = source.Split(delimiter)
		  
		  Dim out(-1) As Double
		  Redim out( UBound(fields) )
		  
		  Dim i As Integer
		  for i = UBound(fields) DownTo 0
		    out(i) = CDbl( fields(i) )
		  next
		  
		  return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SplitToInt(source As String, delimiter As String = " ") As Integer()
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Split a string into fields, then convert each field into an Integer
		  // using the Val function.
		  
		  Dim fields(-1) As String
		  fields = source.Split(delimiter)
		  
		  Dim out(-1) As Integer
		  Redim out( UBound(fields) )
		  
		  Dim i As Integer
		  for i = UBound(fields) DownTo 0
		    out(i) = Val( fields(i) )
		  next
		  
		  return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SplitToVal(source As String, delimiter As String = " ") As Double()
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Split a string into fields, then convert each field into a Double
		  // using the Val function.  This is appropriate for a set of numbers
		  // used only by the computer; for human-readable numbers, consider
		  // using SplitToCDbl instead.
		  
		  Dim fields(-1) As String
		  fields = source.Split(delimiter)
		  
		  Dim out(-1) As Double
		  Redim out( UBound(fields) )
		  
		  Dim i As Integer
		  for i = UBound(fields) DownTo 0
		    out(i) = Val( fields(i) )
		  next
		  
		  return out
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Sprintf(src as string, ParamArray data as Variant) As string
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // By Frank Bitterlich, bitterlich@gsco.de
		  // Returns a string produced according to the formatting string <src>.
		  // The format string <src> is composed of zero or more directives: ordinary
		  // characters (excluding %) that are
		  // copied directly to the result, and conversion
		  // specifications, each of which results in fetching its
		  // own parameter.
		  // For details, see http://de.php.net/manual/en/function.sprintf.php
		  
		  // Attention: This function differs from the PHP sprintf() function in that
		  // it formats floating numbers according to the locale settings.
		  // For example, in Germany,
		  //    sprintf("%04.2f", 123.45)
		  // will return "0123,45".
		  
		  dim rex as new RegEx
		  dim match as RegExMatch
		  dim argtype as string
		  dim padding as string
		  dim alignment as string
		  dim precstr as string
		  dim replacement as string
		  dim frmstr as string
		  dim p, width, precision, index, start, length as integer
		  dim vf as double
		  
		  
		  rex.SearchPattern = "(%)(0|/s|'.)?(-)?(\d*)(\.\d+)?([%bcdeufosxX])"
		  rex.Options.Greedy = true
		  match = rex.Search(src)
		  
		  do until match = nil or index > UBound(data)
		    if match.SubExpressionCount=7 then
		      padding = Right(" " + match.SubExpressionString(2), 1)
		      // if padding = "" then padding = " " // default: space
		      alignment = match.SubExpressionString(3)
		      width = Val(match.SubExpressionString(4))
		      precstr = Mid(match.SubExpressionString(5), 2)
		      precision = Val(precstr)
		      If precstr="" Then 
		        precision = 6
		      End If
		      
		      argtype = match.SubExpressionString(6)
		      select case argtype
		      case "%"
		        replacement = ""
		      case "b" // binary int
		        replacement = bin(data(index))
		      case "c" // character
		        replacement = Chr(data(index))
		        width = 0
		      case "d" // signed int
		        if padding = "0" then
		          frmstr = "-"+Repeat("0", width)
		          If data(index)<0 Then 
		            frmstr = Left(frmstr, Len(frmstr)-1)
		          End If
		        else
		          frmstr = "-#"
		        end if
		        replacement = Format(data(index), frmstr)
		      case "e" // scientific notation
		        vf = data(index)
		        frmstr = "-#."+Repeat("0", precision)+"e+"
		        Replacement = Format(vf, frmstr)
		        p = InStr(Replacement, "e")
		        // Make sure the part after the "e" has two digits
		        Replacement = Left(Replacement, p)+Format(Val(Mid(Replacement, p+1)), "+00")
		      case "u" // unsigned int
		        replacement = Format(data(index), "#")
		      case "f" // signed float
		        if padding = "0" then
		          frmstr = "-"+Repeat("0", width)
		          If data(index)<0 Then 
		            frmstr = Left(frmstr, Len(frmstr)-1)
		          End If
		        else
		          frmstr = "-#"
		        end if
		        if precision > 0 then
		          frmstr = frmstr + "." + Repeat("0", precision)
		        end if
		        Replacement = Format(data(index), frmstr)
		        If precision > 0 And padding<>"0" Then 
		          width = width + precision + 1
		        End If
		      case "o" // octal int
		        replacement = Oct(data(index))
		      case "s" // string
		        replacement = data(index)
		      case "x" // hex int; uppercase "X" means uppercase hex, "x" is lowercase hex
		        replacement = hex(data(index))
		        if asc(argtype) = &h58 then // uppercase "X"
		          replacement = Uppercase(replacement)
		        else // lowercase "x"
		          replacement = lowercase(replacement)
		        end if
		      end select
		      
		      if width>Len(replacement) then
		        if alignment="-" then // align left
		          replacement=replacement+Repeat(padding, width-Len(replacement))
		        else // align right
		          replacement=Repeat(padding, width-Len(replacement))+replacement
		        end if
		      end if
		    end if
		    start = match.SubExpressionStartB(0)+1
		    length = LenB(match.SubExpressionString(0))
		    
		    src = LeftB(src, start-1) + replacement + Mid(src, start+length)
		    
		    index = index + 1
		    match = rex.Search(src, start)
		  loop
		  
		  return src
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SQLify(s As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return a version of s ready for use in an SQL statement.
		  
		  // In other words, we just need to double the apostrophes:
		  return ReplaceAll( s, "'", "''" )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Squeeze(s As String, charSet As String = " ") As string
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Find any repeating characters, where the character is a member of
		  // charSet, and replace the run with a single character.  Example:
		  // Squeeze("wooow maaan", "aeiou") = "wow man".
		  
		  Dim sLenB As Integer = s.LenB
		  If sLenB < 2 Then 
		    Return s
		  End If
		  
		  Dim m As MemoryBlock
		  m = NewMemoryBlock( sLenB )
		  
		  charSet = ConvertEncoding( charSet, s.Encoding )
		  
		  Dim sLen As Integer = s.Len
		  
		  Dim char, lastChar As String
		  Dim charLen, spos, mpos As Integer
		  Dim skip As Boolean
		  for spos = 1 to sLen
		    char = Mid( s, spos, 1 )
		    if char = lastChar then
		      skip = InStrB( charSet, char ) > 0
		    else
		      skip = false
		      lastChar = char
		    end if
		    if not skip then
		      charLen = char.LenB
		      m.StringValue( mpos, charLen ) = char
		      mpos = mpos + charLen
		    end if
		  next
		  
		  return DefineEncoding( m.StringValue(0, mpos), s.Encoding )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StartsWith(extends s As String, withWhat As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return true if 's' starts with the string 'withWhat',
		  // doing a standard string comparison.
		  
		  return Left(s, withWhat.Len) = withWhat
		  
		  // Exception
		  // MsgBox ModPromptStrings.ERROR_INFO_UNKNOW+" ("+CurrentMethodName+")"
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StartsWithB(extends s As String, withWhat As String) As Boolean
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return true if 's' starts with the string 'withWhat',
		  // doing a binary comparison.
		  
		  return StrComp( LeftB(s, withWhat.Len), withWhat, 0 ) = 0
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ThousandsSeparator() As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // Return the thousands separator the user uses (either "." or ",").
		  if mThousandsSeparator = "" then
		    mThousandsSeparator = Format(1111, "#,#")
		    mThousandsSeparator = ReplaceAll( mThousandsSeparator, "1", "" )
		  End If
		  
		  return mThousandsSeparator
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToArray(extends s as string) As string()
		  
		  Return Split( ReplaceLineEndings( s, EndOfLine) , EndOfLine) 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToArray(s as string) As string()
		  
		  Return Split( ReplaceLineEndings( s, EndOfLine) , EndOfLine) 
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToBoolean(extends s as string) As Boolean
		  return s = "TRUE"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToBoolean(s as string) As Boolean
		  return s.ToBoolean
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToColor(extends s as String) As color
		  
		  If s.Left(2) = "&c" Then
		    
		    Dim v As Variant
		    v = s
		    Dim c As Color = v
		    
		    Return c
		    
		  Else
		    
		    Break
		    
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToColor(s as String) As color
		  
		  return s.ToColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Function ToDouble(extends s as string) As Double
		  
		  Return Val(s)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToDouble(s as string) As Double
		  
		  Return s.ToDouble
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target64Bit))
		Function ToInteger(extends s as string) As Integer
		  
		  Return Val(s)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToInteger(s as string) As Integer
		  
		  Return s.ToInteger
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToProperColorString(c as Color) As String
		  
		  Dim r,g,b,a As Integer
		  
		  r = c.red
		  g = c.Green
		  b = c.Blue
		  a = c.Alpha
		  
		  Return "&c" + Right("00" + r.ToHex, 2) + _
		  Right("00" + g.ToHex, 2) + _
		  Right("00" + b.ToHex, 2) + _
		  Right("00" + a.ToHex, 2) 
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Trim(source As String, charsToTrim As String) As String
		  #Pragma BackgroundTasks False
		  #Pragma BoundsChecking False
		  #Pragma NilObjectChecking False
		  
		  // This is an extended version of RB's Trim function that lets you specify
		  // a set of characters to trim.
		  
		  Dim srcLen As Integer = source.Len
		  Dim leftPos, i As Integer
		  for i = 1 to srcLen
		    If InStr( charsToTrim, Mid(source, i, 1) ) = 0 Then 
		      Exit
		    End If
		  next
		  leftPos = i
		  If leftPos > srcLen Then 
		    Return ""
		  End If
		  
		  Dim rightPos As Integer
		  for i = srcLen DownTo 1
		    If InStr( charsToTrim, Mid(source, i, 1) ) = 0 Then 
		      Exit
		    End If
		  next
		  rightPos = i
		  
		  return Mid( source, leftPos, rightPos - leftPos + 1 )
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Contributors
		2024-MAY-25 - updated inside Kitchen Sink as StringUtils appears to NOT be in any public repo it can be updated
		Many additions from Norman Palardy npalardy@great-white-software.com
		    https://github.com/npalardy/KitchenSink
		
		Many people have contributed to the development of this module, including:
		
		Frank Bitterlich, bitterlich@gsco.de
		Jon Johnson, jonj@realsoftware.com
		Joe Strout, joe@strout.net (*)
		Kem Tekinay, ktekinay@mactechnologies.com
		Charles Yeomans, yeomans@desuetude.com
		
		(*) To whom correspondence should be addressed.
	#tag EndNote

	#tag Note, Name = Home Page
		2024-MAY-25 - updated inside Kitchen Sink as StringUtils appears to NOT be in any public repo it can be updated
		The message below _may_ be obsolete depending on where you got this from
		    https://github.com/npalardy/KitchenSink
		
		This StringUtils module is maintained by Joe Strout (joe@strout.net).
		You should be able to find the latest version via this URL:
		
		    http://www.strout.net/info/coding/rb/
	#tag EndNote

	#tag Note, Name = License
		
		This StringUtils module is in the public domain.  You may use it for any purpose
		whatsoever, but it comes with no express or implied warranty of correctness or
		fitness for any purpose.
		
		Share and enjoy!
	#tag EndNote

	#tag Note, Name = Version History
		2024-MAY-25 - updated inside Kitchen Sink as StringUtils appears to NOT be in any public repo it can be updated
		
		
		2004-JUL-17: version 1.0
		- First public release.
		
		2004-JUL-22: version 1.1
		- Fixed some (harmless) warnings in CountRegEx and Repeat.
		- Added ControlCharacters.
		- Added DecimalSeparator.
		- Added ThousandsSeparator.
		- Added SplitByLength and SplitByLengthB.
		- Added Sprintf.
		- Added Trim, LTrim, and RTrim (with charsToTrim parameter).
		- Improved the speed of CountFieldsQuoted substantially.
		- Improved the speed of NthFieldQuoted and Squeeze slightly.
		
		(not yet released)
		- Fixed a bug in the TestSplitToVal unit test.
	#tag EndNote


	#tag Property, Flags = &h0
		mControlChars As String
	#tag EndProperty

	#tag Property, Flags = &h0
		mDecimalSeparator As String
	#tag EndProperty

	#tag Property, Flags = &h0
		mThousandsSeparator As String
	#tag EndProperty


	#tag Constant, Name = kCFStringNormalizationFormC, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCFStringNormalizationFormD, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCFStringNormalizationFormKC, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kCFStringNormalizationFormKD, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = MatchPositions, Flags = &h0
		NoMatch
		  AtStart
		  AtEnd
		  InBetween
		Multiple
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="mControlChars"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mDecimalSeparator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="mThousandsSeparator"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
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
