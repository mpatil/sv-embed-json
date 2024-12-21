  
`define _ERROR_ 257
`define _COMMA 258
`define _COLON 259
`define _LBRACK 260
`define _RBRACK 261
`define _KW_false 262
`define _KW_null 263
`define _KW_true 264
`define _LBRACE 265
`define _RBRACE 266
`define T_AnyChars 267
`define T_DecimalNum 268
`define T_IntegerNum 269
`define T_ScientificNum 270
`define YYNTOKENS 142
`define YYERRCODE 256
  //#line 5 "json.y"
`include "Absyn.svh"
`include "bio.svh"

class Parser;
  Biobuf b;
`include "Lexer.svh"

typedef struct { int i; } YY_BUFFER_STATE;

function int yywrap();
  return 1;
endfunction


static JSON  YY_RESULT_JSON_ = null;


  //#line 24 "json.y"
typedef struct
{
  int    _int;
  byte   _char;
  real   _double;
  string _string;
  JSON  json_;
  Value  value_;
  ListMember_Item  listmember_item_;
  Member_Item  member_item_;
  ListValue  listvalue_;
  String_Literal  string_literal_;
} YYSTYPE;
  //#line 39 "json.y"
task yyerror(string str);
  $display("error: line %0d: %s at %s\n", yy_mylinenumber, str, string'(yytext)); //'
  $fatal;
endtask

task execerror(string s, string t);   /* recover from run-time error */
  if (s != "") $write(" %s ", s);
    if (t != "") $write(" %s ", t);
    $fatal (1, $psprintf("\nFATAL ERROR: line %0d near \"%s\": exiting!!!\n\n", yy_mylinenumber, string'(yytext))); //'
endtask



  //#line 78 "json.y"
/**/
  static bit  yydebug;           //do I want debug output?
  int yynerrs;            //number of errors so far
  int yyerrflag;          //was there an error?
  int yychar = -1;             //the current working character

  //###############################################################
  // method: debug
  //###############################################################
  function void debug(string msg);
    if (yydebug)
      $display(msg);
  endfunction


  //########## STATE STACK ##########
  
  int statestk[$]; //state stack
  //###############################################################
  // methods: state stack push,pop,drop,peek
  //###############################################################
  function void state_push(int state);
    statestk.push_front(state);
  endfunction

  function state_pop();
    return statestk.pop_front();
  endfunction

  function void state_drop(int cnt);
    statestk = statestk[cnt:$];
  endfunction

  static string ascii[] = {"\\0","SOH","STX","ETX","EOT","ENQ","ACK","\\a","\\b","\\t","\\n","\\v","\\f","\\r","SO","SI",
        "DLE","DC1","DC2","DC3","DC4","NAK","SYN","ETB","CAN","EM","SUB","ESC","FS","GS","RS","US",
        "SPACE","!","\"","#","$","%","&","’","(",")","*","+",",","-",".","/",
        "0","1","2","3","4","5","6","7","8","9",":",";","<","=",">","?",
        "@","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O",
        "P","Q","R","S","T","U","V","W","X","Y","Z","[","\\","]","^","_",
        "`","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o",
        "p","q","r","s","t","u","v","w","x","y","z","{","|","}","~","DEL"};

  //###############################################################
  // method: init_stacks : allocate and prepare stacks
  //###############################################################
  function bit init_stacks();
    val_init();
    if (ascii.size() <= 128) init_debug();
    return 1;
  endfunction

  typedef YYSTYPE svtype;
  //########## SEMANTIC VALUES ##########
  //## **user defined:svtype

  string   yytext_;//user variable to return contextual strings
  svtype yyval; //used to return semantic vals from action routines
  svtype yylval;//the 'lval' (result) I got from yylex()
  svtype valstk[$];

  //###############################################################
  // methods: value stack push,pop,drop,peek.
  //###############################################################

  function void val_init();
  //  yyval  = new ();
  //  yylval = new ();
  endfunction

  function void val_push(svtype val);
    valstk.push_front(val);
  endfunction

  function svtype val_pop();
    return valstk.pop_front();
  endfunction

  function void val_drop(int cnt);
    valstk = valstk[cnt:$];
  endfunction

  function svtype dup_yyval(svtype val);
    return val;
  endfunction

  //#### end semantic value section ####
  static int  yylhs[] = { -1,
      0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
      2,    2,    2,    3,    4,    4,    4,    5,  0
  };
  static int  yylen[] = { 2,
      1,    3,    3,    1,    1,    1,    1,    1,    1,    1,
      0,    1,    3,    3,    0,    1,    3,    1,  0
  };
  static int  yydefred[] = { 0,
      0,    9,   10,    8,    0,   18,    6,    7,    5,    0,
      1,    4,    0,    0,    0,    0,    0,    0,    3,    2,
      0,    0,   17,   13,   14,  0
  };
  static int  yydgoto[] = { 10,
     13,   15,   16,   14,   12,0 
  };
  static int  yysindex[] = { -258,
   -258,    0,    0,    0, -264,    0,    0,    0,    0,    0,
      0,    0, -250, -248, -252, -243, -242, -258,    0,    0,
   -264, -258,    0,    0,    0, 0 
  };
  static int  yyrindex[] = { 0,
   -241,    0,    0,    0, -247,    0,    0,    0,    0,    0,
      0,    0, -240,    0,    0, -244,    0, -241,    0,    0,
   -247,    0,    0,    0,    0,0 
  };
  static int  yygindex[] = { 0,
      1,   -3,    0,    6,   -5,0 
  };
`define YYTABLESIZE 24
  int  yytable[] = { 17,
     11,    1,    6,    2,    3,    4,    5,   18,    6,    7,
      8,    9,   19,   20,   21,   17,   22,   24,   11,   15,
     16,   12,   25,   23,0 
  };
  int  yycheck[] = { 5,
      0,  260,  267,  262,  263,  264,  265,  258,  267,  268,
    269,  270,  261,  266,  258,   21,  259,   21,  266,  261,
    261,  266,   22,   18,0 
  };
`define YYFINAL 10
`ifndef YYDEBUG
`define YYDEBUG 0
`endif
`define YYMAXTOKEN 270
  static string yyname[] = {
  "end-of-file","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","","","","","","","","","","","","","",
  "","","","_ERROR_","_COMMA","_COLON","_LBRACK","_RBRACK","_KW_false",
  "_KW_null","_KW_true","_LBRACE","_RBRACE","T_AnyChars","T_DecimalNum",
  "T_IntegerNum","T_ScientificNum","" 
  };
  static string yyrule[] = {
    "$accept : JSON",
    "JSON : Value",
    "Value : _LBRACE ListMember_Item _RBRACE",
    "Value : _LBRACK ListValue _RBRACK",
    "Value : String_Literal",
    "Value : T_ScientificNum",
    "Value : T_DecimalNum",
    "Value : T_IntegerNum",
    "Value : _KW_true",
    "Value : _KW_false",
    "Value : _KW_null",
    "ListMember_Item :",
    "ListMember_Item : Member_Item",
    "ListMember_Item : Member_Item _COMMA ListMember_Item",
    "Member_Item : String_Literal _COLON Value",
    "ListValue :",
    "ListValue : Value",
    "ListValue : Value _COMMA ListValue",
    "String_Literal : T_AnyChars",
    ""
  };

  //###############################################################
  // method: dump_stacks : show n levels of the stacks
  //###############################################################
  function void dump_stacks(int count);
    int i;
    debug($psprintf("=index==state====value=  "));
    for (i=0;i<count;i++)
      debug($psprintf(" %0d %0d %p", i, statestk[i], valstk[i]));
    debug("======================");
  endfunction

  //###############################################################
  // method: yylexdebug : check lexer state
  //###############################################################
  function void yylexdebug(int state,int ch);
    string s;
    if (ch < 0) ch=0;
    if (ch <= `YYMAXTOKEN) //check index bounds
      s = yyname[ch];    //now get it
    if (s == "")
      s = "illegal-symbol";
    debug($psprintf("state %0d, reading %0d (%0s)", state, ch, s));
  endfunction



  //The following are now global, to aid in error reporting
  int yyn;       //next next thing to do
  int yym;       //
  int yystate;   //current parsing state from state table
  string yys;    //current token string
  
  //###############################################################
  // method: yyparse : parse input and execute indicated items
  //###############################################################
  function int yyparse();
    bit doaction;
    init_stacks();
    yynerrs = 0;
    yyerrflag = 0;
    //yychar = -1;          //impossible char forces a read
    yystate=0;            //initial state
    state_push(yystate);  //save it
    val_push(yylval);     //save empty value
    while (1) begin //until parsing is done, either correctly, or w/error
      doaction=1;
      debug("loop"); 
      //#### NEXT ACTION (from reduction table)
      for (yyn = yydefred[yystate]; yyn == 0; yyn = yydefred[yystate]) begin
        debug($psprintf("yyn:%0d  state:%0d  yychar: %s (%0d)", yyn, yystate, ascii[yychar], yychar));
        if (yychar < 0) begin     //we want a char?
          yychar = yylex();  //get next token
          debug($psprintf(" next yychar: %s (%0d)",ascii[yychar], yychar));
          //#### ERROR CHECK ####
          if (yychar < 0) begin   //it it didn't work/error
            yychar = 0;      //change it to default string (no -1!)
            if (yydebug)
              yylexdebug(yystate,yychar);
          end
        end//yychar<0
        yyn = yysindex[yystate];  //get amount to shift by (shift index)
        if (yyn != 0) begin
          yyn += yychar;
          if (yyn >= 0 && yyn <= `YYTABLESIZE && yycheck[yyn] == yychar) begin
            debug($psprintf("state %0d, shifting to state %0d", yystate,yytable[yyn]));
            //#### NEXT STATE ####
            yystate = yytable[yyn];//we are in a new state
            state_push(yystate);   //save it
            val_push(yylval);      //push our lval as the input for next rule
            yychar = -1;           //since we have 'eaten' a token, say we need another
            if (yyerrflag > 0)     //have we recovered an error?
               --yyerrflag;        //give ourselves credit
            doaction=0;            //but don't process yet
            break;                 //quit the yyn=0 loop
          end
        end
        yyn = yyrindex[yystate];  //reduce
        if (yyn != 0) begin
          yyn += yychar;
          if (yyn >= 0 && yyn <= `YYTABLESIZE && yycheck[yyn] == yychar) begin //we reduced!
            debug("reduce");
            yyn = yytable[yyn];
            doaction=1; //get ready to execute
            break;      //drop down to actions
          end else begin
            execerror("Cannot recover from parse error", yys);
            $finish;
          end
        end
        else //ERROR RECOVERY
        begin
          if (yyerrflag==0) begin
            yyerror("syntax error");
            yynerrs++;
          end
          if (yyerrflag < 3) begin //low error count?
            yyerrflag = 3;
            while (1) begin  //do until break
              yyn = yysindex[statestk[0]];
              if (yyn != 0) begin
                yyn += `YYERRCODE;
                if (yyn >= 0 && yyn <= `YYTABLESIZE && yycheck[yyn] == `YYERRCODE) begin
                  debug($psprintf("state %0d, error recovery shifting to state %0d ", statestk[0], yytable[yyn]));
                  yystate = yytable[yyn];
                  state_push(yystate);
                  val_push(yylval);
                  doaction=0;
                  break;
                end
              end
              else
              begin
                debug($psprintf("error recovery discarding state %0d ", statestk[0]));
                state_pop();
                val_pop();
              end
            end
          end
          else //discard this token
          begin
            if (yychar == 0)
              return 1; //yyabort
            if (yydebug) begin
              yys = "";
              if (yychar <= `YYMAXTOKEN) yys = yyname[yychar];
              if (yys == "") yys = "illegal-symbol";
              debug($psprintf("state %0d, error recovery discards token  %s (%0d)", yystate, ascii[yychar], yys));
            end
            yychar = -1;  //read another
          end
        end  //end error recovery
      end   //yyn=0 loop
      if (!doaction)   //any reason not to proceed?
        continue;      //skip action
      yym = yylen[yyn];          //get count of terminals on rhs
      debug($psprintf("state %0d, reducing %0d by rule %0d (%s)", yystate, yym, yyn, yyrule[yyn]));
      if (yym>0)                 //if count of rhs not 'nil'
        yyval = valstk[yym-1]; //get current semantic value
      yyval = dup_yyval(yyval);  //duplicate yyval if ParserVal is used as semantic value
      case(yyn)
      //########## USER-SUPPLIED ACTIONS ##########
      1:  //#line 82 "json.y"
      begin
          yyval.json_ = JSONValue::new (valstk[0].value_); yyval.json_.line_number = yy_mylinenumber;YY_RESULT_JSON_ = yyval.json_; 
      end
      2:  //#line 84 "json.y"
      begin
          valstk[1].listmember_item_.v.reverse ;yyval.value_ = ObjectVal::new (valstk[1].listmember_item_); yyval.value_.line_number = yy_mylinenumber; 
      end
      3:  //#line 85 "json.y"
      begin
          valstk[1].listvalue_.v.reverse ;yyval.value_ = ArrayVal::new (valstk[1].listvalue_); yyval.value_.line_number = yy_mylinenumber; 
      end
      4:  //#line 86 "json.y"
      begin
          yyval.value_ = StringVal::new (valstk[0].string_literal_); yyval.value_.line_number = yy_mylinenumber; 
      end
      5:  //#line 87 "json.y"
      begin
          yyval.value_ = ScientificNumberVal::new (valstk[0]._string); yyval.value_.line_number = yy_mylinenumber; 
      end
      6:  //#line 88 "json.y"
      begin
          yyval.value_ = DecimalNumberVal::new (valstk[0]._string); yyval.value_.line_number = yy_mylinenumber; 
      end
      7:  //#line 89 "json.y"
      begin
          yyval.value_ = IntegerNumberVal::new (valstk[0]._string); yyval.value_.line_number = yy_mylinenumber; 
      end
      8:  //#line 90 "json.y"
      begin
          yyval.value_ = TrueVal::new (); yyval.value_.line_number = yy_mylinenumber; 
      end
      9:  //#line 91 "json.y"
      begin
          yyval.value_ = FalseVal::new (); yyval.value_.line_number = yy_mylinenumber; 
      end
      10:  //#line 92 "json.y"
      begin
          yyval.value_ = NullVal::new (); yyval.value_.line_number = yy_mylinenumber; 
      end
      11:  //#line 94 "json.y"
      begin
          yyval.listmember_item_ = ListMember_Item::new(); 
      end
      12:  //#line 95 "json.y"
      begin
          yyval.listmember_item_ = ListMember_Item::new(); yyval.listmember_item_.v.push_back(valstk[0].member_item_); 
      end
      13:  //#line 96 "json.y"
      begin
          valstk[0].listmember_item_.v.push_back(valstk[2].member_item_); yyval.listmember_item_ = valstk[0].listmember_item_; 
      end
      14:  //#line 98 "json.y"
      begin
          yyval.member_item_ = Member::new (valstk[2].string_literal_, valstk[0].value_); yyval.member_item_.line_number = yy_mylinenumber; 
      end
      15:  //#line 100 "json.y"
      begin
          yyval.listvalue_ = ListValue::new(); 
      end
      16:  //#line 101 "json.y"
      begin
          yyval.listvalue_ = ListValue::new(); yyval.listvalue_.v.push_back(valstk[0].value_); 
      end
      17:  //#line 102 "json.y"
      begin
          valstk[0].listvalue_.v.push_back(valstk[2].value_); yyval.listvalue_ = valstk[0].listvalue_; 
      end
      18:  //#line 104 "json.y"
      begin
          yyval.string_literal_ = StringLit::new (valstk[0]._string); yyval.string_literal_.line_number = yy_mylinenumber; 
      end
      //########## END OF USER-SUPPLIED ACTIONS ##########
      endcase //case
      //#### Now let's reduce... ####
      debug("reduce");
      state_drop(yym);             //we just reduced yylen states
      yystate = statestk[0];     //get new state
      val_drop(yym);               //corresponding value drop
      yym = yylhs[yyn];            //select next TERMINAL(on lhs)
      if (yystate == 0 && yym == 0) begin//done? 'rest' state and at first TERMINAL
        debug($psprintf("After reduction, shifting from state 0 to state %0d",`YYFINAL));
        yystate = `YYFINAL;         //explicitly say we're done
        state_push(`YYFINAL);       //and save it
        val_push(yyval);           //also save the semantic value of parsing
        if (yychar < 0) begin      //we want another character?
          yychar = yylex();        //get next character
          debug($psprintf(" next yychar: %s (%0d)",ascii[yychar], yychar));
          if (yychar<0) yychar=0;  //clean, if necessary
          if (yydebug)
            yylexdebug(yystate,yychar);
        end
        if (yychar == 0)          //Good exit (if lex returns 0 ;-)
           break;                 //quit the loop--all DONE
      end//if yystate
      else                        //else not done yet
      begin                         //get next state and push, for next yydefred[]
        yyn = yygindex[yym];      //find out where to go
        if (yyn != 0) begin
          yyn += yystate;
          if (yyn >= 0 && yyn <= `YYTABLESIZE && yycheck[yyn] == yystate)
            yystate = yytable[yyn]; //get new state
          else
            yystate = yydgoto[yym]; //else go to new defred
        end
        else
          yystate = yydgoto[yym]; //else go to new defred
        debug($psprintf("after reduction, shifting from state %0d to state %0d", statestk[0], yystate));
        state_push(yystate);     //going again, so push state & val...
        val_push(yyval);         //for next action
      end
    end//main loop
    return 0;//yyaccept!!
  endfunction
  //## end of method parse() ######################################
  

  //###############################################################
  task init_debug();
    automatic int idx = `YYMAXTOKEN - `YYNTOKENS;
    ascii = new [`YYNTOKENS + 128] (ascii);
    for (int l = 128; l <= 128 + `YYNTOKENS; l++, idx++) begin
      ascii[l] = yyname[idx];
    end
  endtask
  

  //#line 108 "json.y"

endclass


/* Entrypoint: parse JSON from file. */
function JSON pJSON(string filename);
automatic Parser p = new();
  p.b = Bopen(filename, `OREAD);
  p.yy_mylinenumber = 1;
  p.initialize_lexer(0);
  if (p.yyparse())
    return null; /* Failure */
  else
    return p.YY_RESULT_JSON_;/* Success */
endfunction

/* Entrypoint: parse JSON from string. */
function JSON psJSON(string str);
automatic Parser p = new();
  p.b = Bopens(str);
  p.yy_mylinenumber = 1;
  p.initialize_lexer(0);
  if (p.yyparse())
    return null; /* Failure */
  else
    return p.YY_RESULT_JSON_;/* Success */
endfunction



