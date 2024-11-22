/* -*- sv -*- File generated by the BNF Converter (bnfc 2.9.6). */

/*******************************************************/
`include "Interp.svh"

task Interp::visitJSON(JSON p); endtask //abstract class
task Interp::visitValue(Value p); endtask //abstract class
task Interp::visitMember_Item(Member_Item p); endtask //abstract class
task Interp::visitString_Literal(String_Literal p); endtask //abstract class

task Interp::visitJSONValue(JSONValue p);
  p.value_.accept(this);
endtask

task Interp::visitObjectVal(ObjectVal p);
  ObjectVal_ v = new();
  push(v);

  p.listmember_item_.accept(this);
endtask

task Interp::visitArrayVal(ArrayVal p);
  ArrayVal_ v = new();
  push(v);

  p.listvalue_.accept(this);
endtask

task Interp::visitStringVal(StringVal p);
  StringVal_ v;

  p.string_literal_.accept(this);

  v = new(currTermTok);
  push(v);
endtask

task Interp::visitIntegerNumberVal(IntegerNumberVal p);
  NumberVal_ v;

  visitIntegerNum(p.integernum_);

  v = new(currTermTok.atoi());
  push(v);
endtask

task Interp::visitDecimalNumberVal(DecimalNumberVal p);
  NumberVal_ v;

  visitDecimalNum(p.decimalnum_);

  v = new(currTermTok.atoreal());
  push(v);
endtask

task Interp::visitScientificNumberVal(ScientificNumberVal p);
  NumberVal_ v;

  visitScientificNum(p.scientificnum_);

  v = new(currTermTok.atoreal());
  push(v);
endtask

task Interp::visitTrueVal(TrueVal p);
  BoolVal_ v = new(1);
  push(v);
endtask

task Interp::visitFalseVal(FalseVal p);
  BoolVal_ v = new(0);
  push(v);
endtask

task Interp::visitNullVal(NullVal p);
  NullVal_ v = new();
  push(v);
endtask

task Interp::visitMember(Member p);
  StringVal_ k;

  p.string_literal_.accept(this);

  k = new(currTermTok);
  push(k);
  p.value_.accept(this);
endtask

task Interp::visitStringLit(StringLit p);
  visitAnyChars(p.anychars_);
endtask

task Interp::visitListMember_Item(ListMember_Item  listmember_item);
  ObjectVal_ v;
  $cast(v, pop());

  for ( int i = 0; i < listmember_item.v.size() ; i++)
  begin
    Val_ val;
    StringVal_ k;

    listmember_item.v[i].accept(this);

    val = pop();
    $cast(k, pop());
    v.append(k.asString(), val);
  end

  push(v);
endtask

task Interp::visitListValue(ListValue  listvalue);
  ArrayVal_ v;
  $cast(v, pop());

  for ( int i = 0; i < listvalue.v.size() ; i++)
  begin
    Val_ e;

    listvalue.v[i].accept(this);

    e = pop();
    v.append(e);
  end
  push(v);
endtask

task Interp::visitIntegerNum(IntegerNum x);
  currTermTok = x;
endtask

task Interp::visitDecimalNum(DecimalNum x);
  currTermTok = x;
endtask

task Interp::visitScientificNum(ScientificNum x);
  currTermTok = x;
endtask

task Interp::visitAnyChars(AnyChars x);
  currTermTok = x;
endtask

task Interp::visitInteger(Integer x);
endtask

task Interp::visitChar(Char x);
endtask

task Interp::visitDouble(Double x);
endtask

task Interp::visitString(String x);
endtask

task Interp::visitIdent(Ident x);
endtask
