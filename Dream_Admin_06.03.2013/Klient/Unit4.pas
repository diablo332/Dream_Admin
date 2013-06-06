unit Unit4;

interface

uses Classes, SysUtils;

type
  PMD5Digest = ^TMD5Digest;

  TMD5Digest = Record
    Case Integer Of
      0: (A, B, C, D: LongInt);
      1: (v: Array[0..15] Of Byte);
  End;

  Function MD5String(Const S: String): TMD5Digest;

{ The MD5File function evaluates the MD5 hashsum for
 a file. The FileName parameter specifies the name
 of a file to evaluate hashsum }
Function MD5File(Const FileName: String): TMD5Digest;

{ The MD5Stream function evaluates the MD5 hashsum for
 a stream. The Stream parameters specifies the
 TStream descendant class object to evaluate hashsum }
Function MD5Stream(Const Stream: TStream): TMD5Digest;

{ The MD5Buffer function evaluates the MD5 hashsum for
 any memory buffer. The Buffer parameters specifies a
 buffer to evaluate hashsum. The Size parameter specifies
 the size (in bytes) of a buffer }
Function MD5Buffer(Const Buffer; Size: Integer): TMD5Digest;

{ The MD5DigestToStr function converts the result of
 a hashsum evaluation function into a string of
 hexadecimal digits }
Function MD5DigestToStr(Const Digest: TMD5Digest): String;


{ The MD5DigestCompare function compares two
 TMD5Digest record variables. This function returns
 TRUE if parameters are equal or FALSE otherwise }
 Function MD5DigestCompare(Const Digest1, Digest2: TMD5Digest): Boolean;
     function FileCRC32(const FileName: string): Cardinal;
function UpdateCRC32(InitCRC: Cardinal; BufPtr: Pointer; Len: Word): LongInt;


implementation

type
CRCTable = array[0..255] of Cardinal;
UINT4 = LongWord;

  PArray4UINT4 = ^TArray4UINT4;
  TArray4UINT4 = Array[0..3] Of UINT4;
  PArray2UINT4 = ^TArray2UINT4;
  TArray2UINT4 = Array[0..1] Of UINT4;
  PArray16Byte = ^TArray16Byte;
  TArray16Byte = Array[0..15] Of Byte;
  PArray64Byte = ^TArray64Byte;
  TArray64Byte = Array[0..63] Of Byte;

  PByteArray = ^TByteArray;
  TByteArray = Array[0..0] Of Byte;

  PUINT4Array = ^TUINT4Array;
  TUINT4Array = Array[0..0] Of UINT4;

  PMD5Context = ^TMD5Context;
  TMD5Context = Record
    state: TArray4UINT4;
    count: TArray2UINT4;
    buffer: TArray64Byte;
  End;
const
BufLen = 32768;
 S11 = 7;
  S12 = 12;
  S13 = 17;
  S14 = 22;
  S21 = 5;
  S22 = 9;
  S23 = 14;
  S24 = 20;
  S31 = 4;
  S32 = 11;
  S33 = 16;
  S34 = 23;
  S41 = 6;
  S42 = 10;
  S43 = 15;
  S44 = 21;
CRC32Table: CRCTable =
($00000000, $77073096, $EE0E612C, $990951BA,
$076DC419, $706AF48F, $E963A535, $9E6495A3,
$0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988,
$09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,

$1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
$1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
$136C9856, $646BA8C0, $FD62F97A, $8A65C9EC,
$14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,

$3B6E20C8, $4C69105E, $D56041E4, $A2677172,
$3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
$35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940,
$32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,

$26D930AC, $51DE003A, $C8D75180, $BFD06116,
$21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
$2802B89E, $5F058808, $C60CD9B2, $B10BE924,
$2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,

$76DC4190, $01DB7106, $98D220BC, $EFD5102A,
$71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
$7807C9A2, $0F00F934, $9609A88E, $E10E9818,
$7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,

$6B6B51F4, $1C6C6162, $856530D8, $F262004E,
$6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
$65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C,
$62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,

$4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
$4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
$4369E96A, $346ED9FC, $AD678846, $DA60B8D0,
$44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,

$5005713C, $270241AA, $BE0B1010, $C90C2086,
$5768B525, $206F85B3, $B966D409, $CE61E49F,
$5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4,
$59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,

$EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A,
$EAD54739, $9DD277AF, $04DB2615, $73DC1683,
$E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
$E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,

$F00F9344, $8708A3D2, $1E01F268, $6906C2FE,
$F762575D, $806567CB, $196C3671, $6E6B06E7,
$FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC,
$F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,

$D6D6A3E8, $A1D1937E, $38D8C2C4, $04FDFF252,
$D1BB67F1, $A6BC5767, $3FB506DD, $048B2364B,
$D80D2BDA, $AF0A1B4C, $36034AF6, $041047A60,
$DF60EFC3, $A867DF55, $316E8EEF, $04669BE79,

$CB61B38C, $BC66831A, $256FD2A0, $5268E236,
$CC0C7795, $BB0B4703, $220216B9, $5505262F,
$C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04,
$C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,

$9B64C2B0, $EC63F226, $756AA39C, $026D930A,
$9C0906A9, $EB0E363F, $72076785, $05005713,
$95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38,
$92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,

$86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E,
$81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
$88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
$8F659EFF, $F862AE69, $616BFFD3, $166CCF45,

$A00AE278, $D70DD2EE, $4E048354, $3903B3C2,
$A7672661, $D06016F7, $4969474D, $3E6E77DB,
$AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0,
$A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,

$BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6,
$BAD03605, $CDD70693, $54DE5729, $23D967BF,
$B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94,
$B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);

var
Buf: array[1..BufLen] of Byte;
  Padding: TArray64Byte =
  ($80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
    Function _F(x, y, z: UINT4): UINT4;
Begin
  Result := (((x) And (y)) Or ((Not x) And (z)));
End;

Function _G(x, y, z: UINT4): UINT4;
Begin
  Result := (((x) And (z)) Or ((y) And (Not z)));
End;

Function _H(x, y, z: UINT4): UINT4;
Begin
  Result := ((x) Xor (y) Xor (z));
End;

Function _I(x, y, z: UINT4): UINT4;
Begin
  Result := ((y) Xor ((x) Or (Not z)));
End;
  

Function ROTATE_LEFT(x, n: UINT4): UINT4;
Begin
  Result := (((x) Shl (n)) Or ((x) Shr (32 - (n))));
End;

Procedure FF(Var a: UINT4; b, c, d, x, s, ac: UINT4);
Begin
  a := a + _F(b, c, d) + x + ac;
  a := ROTATE_LEFT(a, s);
  a := a + b;
End;

Procedure GG(Var a: UINT4; b, c, d, x, s, ac: UINT4);
Begin
  a := a + _G(b, c, d) + x + ac;
  a := ROTATE_LEFT(a, s);
  a := a + b;
End;

Procedure HH(Var a: UINT4; b, c, d, x, s, ac: UINT4);
Begin
  a := a + _H(b, c, d) + x + ac;
  a := ROTATE_LEFT(a, s);
  a := a + b;
End;

Procedure II(Var a: UINT4; b, c, d, x, s, ac: UINT4);
Begin
  a := a + _I(b, c, d) + x + ac;
  a := ROTATE_LEFT(a, s);
  a := a + b;
End;

Procedure MD5Encode(Output: PByteArray; Input: PUINT4Array; Len: LongWord);
Var
  i, j: LongWord;
Begin
  j := 0;
  i := 0;
  While j < Len Do Begin
    output[j] := Byte(input[i] And $FF);
    output[j + 1] := Byte((input[i] Shr 8) And $FF);
    output[j + 2] := Byte((input[i] Shr 16) And $FF);
    output[j + 3] := Byte((input[i] Shr 24) And $FF);
    Inc(j, 4);
    Inc(i);
  End;
End;

Procedure MD5Decode(Output: PUINT4Array; Input: PByteArray; Len: LongWord);
Var
  i, j: LongWord;
Begin
  j := 0;
  i := 0;
  While j < Len Do Begin
    Output[i] := UINT4(input[j]) Or (UINT4(input[j + 1]) Shl 8) Or
      (UINT4(input[j + 2]) Shl 16) Or (UINT4(input[j + 3]) Shl 24);
    Inc(j, 4);
    Inc(i);
  End;
End;

Procedure MD5_memcpy(Output: PByteArray; Input: PByteArray; Len: LongWord);
Begin
  Move(Input^, Output^, Len);
End;

Procedure MD5_memset(Output: PByteArray; Value: Integer; Len: LongWord);
Begin
  FillChar(Output^, Len, Byte(Value));
End;

Procedure MD5Transform(State: PArray4UINT4; Buffer: PArray64Byte);
Var
  a, b, c, d: UINT4;
  x: Array[0..15] Of UINT4;
Begin
  a := State[0]; b := State[1]; c := State[2]; d := State[3];
  MD5Decode(PUINT4Array(@x), PByteArray(Buffer), 64);

  FF(a, b, c, d, x[0], S11, $D76AA478);
  FF(d, a, b, c, x[1], S12, $E8C7B756);
  FF(c, d, a, b, x[2], S13, $242070DB);
  FF(b, c, d, a, x[3], S14, $C1BDCEEE);
  FF(a, b, c, d, x[4], S11, $F57C0FAF);
  FF(d, a, b, c, x[5], S12, $4787C62A);
  FF(c, d, a, b, x[6], S13, $A8304613);
  FF(b, c, d, a, x[7], S14, $FD469501);
  FF(a, b, c, d, x[8], S11, $698098D8);
  FF(d, a, b, c, x[9], S12, $8B44F7AF);
  FF(c, d, a, b, x[10], S13, $FFFF5BB1);
  FF(b, c, d, a, x[11], S14, $895CD7BE);
  FF(a, b, c, d, x[12], S11, $6B901122);
  FF(d, a, b, c, x[13], S12, $FD987193);
  FF(c, d, a, b, x[14], S13, $A679438E);
  FF(b, c, d, a, x[15], S14, $49B40821);

  GG(a, b, c, d, x[1], S21, $F61E2562);
  GG(d, a, b, c, x[6], S22, $C040B340);
  GG(c, d, a, b, x[11], S23, $265E5A51);
  GG(b, c, d, a, x[0], S24, $E9B6C7AA);
  GG(a, b, c, d, x[5], S21, $D62F105D);
  GG(d, a, b, c, x[10], S22, $2441453);
  GG(c, d, a, b, x[15], S23, $D8A1E681);
  GG(b, c, d, a, x[4], S24, $E7D3FBC8);
  GG(a, b, c, d, x[9], S21, $21E1CDE6);
  GG(d, a, b, c, x[14], S22, $C33707D6);
  GG(c, d, a, b, x[3], S23, $F4D50D87);

  GG(b, c, d, a, x[8], S24, $455A14ED);
  GG(a, b, c, d, x[13], S21, $A9E3E905);
  GG(d, a, b, c, x[2], S22, $FCEFA3F8);
  GG(c, d, a, b, x[7], S23, $676F02D9);
  GG(b, c, d, a, x[12], S24, $8D2A4C8A);

  HH(a, b, c, d, x[5], S31, $FFFA3942);
  HH(d, a, b, c, x[8], S32, $8771F681);
  HH(c, d, a, b, x[11], S33, $6D9D6122);
  HH(b, c, d, a, x[14], S34, $FDE5380C);
  HH(a, b, c, d, x[1], S31, $A4BEEA44);
  HH(d, a, b, c, x[4], S32, $4BDECFA9);
  HH(c, d, a, b, x[7], S33, $F6BB4B60);
  HH(b, c, d, a, x[10], S34, $BEBFBC70);
  HH(a, b, c, d, x[13], S31, $289B7EC6);
  HH(d, a, b, c, x[0], S32, $EAA127FA);
  HH(c, d, a, b, x[3], S33, $D4EF3085);
  HH(b, c, d, a, x[6], S34, $4881D05);
  HH(a, b, c, d, x[9], S31, $D9D4D039);
  HH(d, a, b, c, x[12], S32, $E6DB99E5);
  HH(c, d, a, b, x[15], S33, $1FA27CF8);
  HH(b, c, d, a, x[2], S34, $C4AC5665);

  II(a, b, c, d, x[0], S41, $F4292244);
  II(d, a, b, c, x[7], S42, $432AFF97);
  II(c, d, a, b, x[14], S43, $AB9423A7);
  II(b, c, d, a, x[5], S44, $FC93A039);
  II(a, b, c, d, x[12], S41, $655B59C3);
  II(d, a, b, c, x[3], S42, $8F0CCC92);
  II(c, d, a, b, x[10], S43, $FFEFF47D);
  II(b, c, d, a, x[1], S44, $85845DD1);
  II(a, b, c, d, x[8], S41, $6FA87E4F);
  II(d, a, b, c, x[15], S42, $FE2CE6E0);
  II(c, d, a, b, x[6], S43, $A3014314);
  II(b, c, d, a, x[13], S44, $4E0811A1);
  II(a, b, c, d, x[4], S41, $F7537E82);
  II(d, a, b, c, x[11], S42, $BD3AF235);
  II(c, d, a, b, x[2], S43, $2AD7D2BB);
  II(b, c, d, a, x[9], S44, $EB86D391);

  Inc(State[0], a);
  Inc(State[1], b);
  Inc(State[2], c);
  Inc(State[3], d);

  MD5_memset(PByteArray(@x), 0, SizeOf(x));
End;


Procedure MD5Init(Var Context: TMD5Context);
Begin
  FillChar(Context, SizeOf(Context), 0);
  Context.state[0] := $67452301;
  Context.state[1] := $EFCDAB89;
  Context.state[2] := $98BADCFE;
  Context.state[3] := $10325476;
End;

Procedure MD5Update(Var Context: TMD5Context; Input: PByteArray; InputLen: LongWord);
Var
  i, index, partLen: LongWord;

Begin
  index := LongWord((context.count[0] Shr 3) And $3F);
  Inc(Context.count[0], UINT4(InputLen) Shl 3);
  If Context.count[0] < UINT4(InputLen) Shl 3 Then Inc(Context.count[1]);
  Inc(Context.count[1], UINT4(InputLen) Shr 29);
  partLen := 64 - index;
  If inputLen >= partLen Then Begin
    MD5_memcpy(PByteArray(@Context.buffer[index]), Input, PartLen);
    MD5Transform(@Context.state, @Context.buffer);
    i := partLen;
    While i + 63 < inputLen Do Begin
      MD5Transform(@Context.state, PArray64Byte(@Input[i]));
      Inc(i, 64);
    End;
    index := 0;
  End Else i := 0;
  MD5_memcpy(PByteArray(@Context.buffer[index]), PByteArray(@Input[i]), inputLen - i);
End;


Procedure MD5Final(Var Digest: TMD5Digest; Var Context: TMD5Context);
Var
  bits: Array[0..7] Of Byte;
  index, padLen: LongWord;
Begin
  MD5Encode(PByteArray(@bits), PUINT4Array(@Context.count), 8);
  index := LongWord((Context.count[0] Shr 3) And $3F);
  If index < 56 Then padLen := 56 - index Else padLen := 120 - index;
  MD5Update(Context, PByteArray(@PADDING), padLen);
  MD5Update(Context, PByteArray(@Bits), 8);
  MD5Encode(PByteArray(@Digest), PUINT4Array(@Context.state), 16);
  MD5_memset(PByteArray(@Context), 0, SizeOf(Context));
End;

Function MD5DigestToStr(Const Digest: TMD5Digest): String;
Var
  i: Integer;
Begin
  Result := '';
  For i := 0 To 15 Do Result := Result + IntToHex(Digest.v[i], 2);
End;

Function MD5String(Const S: String): TMD5Digest;
Begin
  Result := MD5Buffer(PChar(S)^, Length(S));
End;

Function MD5File(Const FileName: String): TMD5Digest;
Var
  F: TFileStream;
Begin

  Try
  F := TFileStream.Create(FileName, fmOpenRead);
  except

  End;
    Result := MD5Stream(F);
    F.Free;

End;

Function MD5Stream(Const Stream: TStream): TMD5Digest;
Var
  Context: TMD5Context;
  Buffer: Array[0..4095] Of Byte;
  Size: Integer;
  ReadBytes: Integer;
  TotalBytes: Integer;
  SavePos: Integer;
Begin
  MD5Init(Context);
  Size := Stream.Size;
  SavePos := Stream.Position;
  TotalBytes := 0;
  Try
    Stream.Seek(0, soFromBeginning);
    Repeat
      ReadBytes := Stream.Read(Buffer, SizeOf(Buffer));
      Inc(TotalBytes, ReadBytes);
      MD5Update(Context, @Buffer, ReadBytes);
    Until (ReadBytes = 0) Or (TotalBytes = Size);
  Finally
    Stream.Seek(SavePos, soFromBeginning);
  End;
  MD5Final(Result, Context);
End;

Function MD5Buffer(Const Buffer; Size: Integer): TMD5Digest;
Var
  Context: TMD5Context;
Begin
  MD5Init(Context);
  MD5Update(Context, PByteArray(@Buffer), Size);
  MD5Final(Result, Context);
End;

Function MD5DigestCompare(Const Digest1, Digest2: TMD5Digest): Boolean;
Begin
  Result := False;
  If Digest1.A <> Digest2.A Then Exit;
  If Digest1.B <> Digest2.B Then Exit;
  If Digest1.C <> Digest2.C Then Exit;
  If Digest1.D <> Digest2.D Then Exit;
  Result := True;
End;
function UpdateCRC32(InitCRC: Cardinal; BufPtr: Pointer; Len: Word): LongInt; 
var
crc: Cardinal; 
index: Integer;
i: Cardinal; 
begin
crc := InitCRC; 
for i := 0 to Len - 1 do
begin 
index := (crc xor Cardinal(Pointer(Cardinal(BufPtr) + i)^)) and $000000FF;
crc := (crc shr 8) xor CRC32Table[index];
end;
Result := crc; 
end;

function FileCRC32(const FileName: string): Cardinal;
var 
InFile: TFileStream;
crc32: Cardinal; 
Res: Integer;
BufPtr: Pointer; 
begin
BufPtr := @Buf; 
crc32 := $FFFFFFFF;
try 
InFile := TFileStream.Create(FileName, fmShareDenyNone);
Res := InFile.Read(Buf, BufLen); 
while (Res <> 0) do
begin
crc32 := UpdateCrc32(crc32, BufPtr, Res);
Res := InFile.Read(Buf, BufLen); 
end;
InFile.Destroy; 
except
on E: Exception do 
begin
if Assigned(InFile) then 
InFile.Free;
//ShowMessage(Format('При обработке файла [%s] вышла ' +
//'вот такая oшибочка [%s]', [FileName, E.Message]));
end;
end;
Result := not crc32; 
end;


end.
