`ifdef MAIN
module lex;
`endif

//`define LEXDEBUG

`define NLSTATE yyprevious = `YYNEWLINE
`define BEGIN yybgin_ptr = 1 +
`define INITIAL 0
`define YYLERR 0
`define YYSTATE (yyestate_ptr - 1)
`define YYTYPE byte unsigned
`define BUFSIZ 4096 
`ifndef YYLMAX 
`define YYLMAX `BUFSIZ
`endif 

`define lex_output(c) $write(c)
`define unput(c) begin yytchar = (c); if(yytchar == "\n") yylineno--; end
`define yymore() (yymorfg=1)
int yyleng;
int yybgin_ptr = 1;

`define YYISARRAY

typedef byte unsigned Bus[$];
Bus yytext;

int yymorfg;
byte yytchar;
int yyin = -1, yyout = -1;

int yylineno = 1;

function int lex_input();
  yytchar = b.Bgetc();
  if (yytchar == 10) yylineno++;
  if (yytchar == `Beof) return 0;
  lex_input = yytchar;
endfunction

task _yyioinit();
    yyin = 0; yyout = 1;
endtask

typedef struct {
    `YYTYPE verify, advance;
} YYWork;

typedef struct {
  int yystoff_ptr;
  int yyother_ptr;
  int yystops_ptr;
} YYSvf;

/* -*- sv -*- File generated by the BNF Converter (bnfc 2.9.6). */
/* Lexer definition for use with lex */
/* This lex file was machine-generated */
`define YY_BUFFER_LENGTH 4096

string YY_PARSED_STRING;
task YY_BUFFER_APPEND(string s);
  s = {YY_PARSED_STRING, s}; //Do something better here!
endtask
task YY_BUFFER_RESET();
  for(int x = 0; x < `YY_BUFFER_LENGTH; x++)
    YY_PARSED_STRING[x] = 0;
endtask

int yy_mylinenumber = 0;
`define STRING_CAST(x)  string'(x)

`define YYINITIAL 2
`define CHAR 4
`define CHARESC 6
`define CHAREND 8
`define STRING 10
`define ESCAPED 12
`define YYNEWLINE 10
function int yylex();
	automatic int nstr = 0; //int yyprevious;
  if (yyin == -1) yyin = 0;
  if (yyout == -1) yyout = 1;
  while ((nstr = yylook()) >= 0) begin
    case(nstr)
      0: if(yywrap()) return(0);
      1:      	 return `_LBRACE;
      2:      	 return `_RBRACE;
      3:      	 return `_LBRACK;
      4:      	 return `_RBRACK;
      5:      	 return `_COMMA;
      6:      	 return `_COLON;
      7:      	 return `_KW_false;
      8:      	 return `_KW_null;
      9:      	 return `_KW_true;
      10:    	 begin  yylval._string = `STRING_CAST(yytext); return `T_IntegerNum;  end
      11:    	 begin  yylval._string = `STRING_CAST(yytext); return `T_DecimalNum;  end
      12:    	 begin  yylval._string = `STRING_CAST(yytext); return `T_ScientificNum;  end
      13:    	 begin  yylval._string = `STRING_CAST(yytext); return `T_AnyChars;  end
      14:  ++yy_mylinenumber ;
      15:      	 /* ignore white space. */;
      16:      	 return `_ERROR_;
      -1: ;
      default: $display($psprintf("bad switch yylook %d",nstr));
    endcase
  end
  return(0);
endfunction /* end of yylex */

/*# line 57 "json.l"*/
 /* Initialization code. */
task initialize_lexer(int inp); `BEGIN `YYINITIAL; endtask



int yyvstop[] = {
0,
14, 0, 
16, 0, 
15, 16, 0, 
14, 15, 0, 
16, 0, 
16, 0, 
5, 16, 0, 
10, 16, 0, 
10, 16, 0, 
6, 16, 0, 
3, 16, 0, 
4, 16, 0, 
16, 0, 
16, 0, 
16, 0, 
1, 16, 0, 
2, 16, 0, 
13, 0, 
10, 0, 
10, 0, 
11, 0, 
12, 0, 
8, 0, 
9, 0, 
7, 0, 
 0 };

//# define YYTYPE byte unsigned
YYWork yycrank[] = '{
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 3, 16 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 1, 15 },	
 '{ 3, 17 },	 '{ 3, 18 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 19, 32 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 3, 19 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 19, 32 },	 '{ 19, 32 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 3, 20 },	 '{ 3, 21 },	
 '{ 3, 20 },	 '{ 22, 37 },	 '{ 0, 0 },	 '{ 3, 22 },	
 '{ 3, 23 },	 '{ 3, 23 },	 '{ 3, 23 },	 '{ 3, 23 },	
 '{ 3, 23 },	 '{ 3, 23 },	 '{ 3, 23 },	 '{ 3, 23 },	
 '{ 3, 23 },	 '{ 3, 24 },	 '{ 4, 20 },	 '{ 4, 21 },	
 '{ 4, 20 },	 '{ 19, 33 },	 '{ 0, 0 },	 '{ 34, 32 },	
 '{ 4, 23 },	 '{ 4, 23 },	 '{ 4, 23 },	 '{ 4, 23 },	
 '{ 4, 23 },	 '{ 4, 23 },	 '{ 4, 23 },	 '{ 4, 23 },	
 '{ 4, 23 },	 '{ 4, 24 },	 '{ 0, 0 },	 '{ 19, 32 },	
 '{ 20, 35 },	 '{ 20, 36 },	 '{ 20, 36 },	 '{ 20, 36 },	
 '{ 20, 36 },	 '{ 20, 36 },	 '{ 20, 36 },	 '{ 20, 36 },	
 '{ 20, 36 },	 '{ 20, 36 },	 '{ 23, 37 },	 '{ 0, 0 },	
 '{ 23, 36 },	 '{ 32, 34 },	 '{ 3, 25 },	 '{ 3, 16 },	
 '{ 3, 26 },	 '{ 36, 37 },	 '{ 27, 39 },	 '{ 36, 36 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 42, 38 },	 '{ 47, 50 },	
 '{ 22, 38 },	 '{ 3, 27 },	 '{ 48, 51 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 39, 45 },	 '{ 4, 25 },	 '{ 4, 16 },	
 '{ 4, 26 },	 '{ 3, 28 },	 '{ 40, 46 },	 '{ 29, 41 },	
 '{ 45, 48 },	 '{ 46, 49 },	 '{ 28, 40 },	 '{ 3, 29 },	
 '{ 41, 47 },	 '{ 4, 27 },	 '{ 0, 0 },	 '{ 19, 34 },	
 '{ 0, 0 },	 '{ 34, 32 },	 '{ 3, 30 },	 '{ 0, 0 },	
 '{ 3, 31 },	 '{ 4, 28 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 4, 29 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 0, 0 },	 '{ 4, 30 },	 '{ 34, 32 },	
 '{ 4, 31 },	 '{ 23, 38 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 0, 0 },	 '{ 34, 32 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 36, 38 },	 '{ 37, 42 },	 '{ 37, 42 },	 '{ 37, 42 },	
 '{ 37, 42 },	 '{ 37, 42 },	 '{ 37, 42 },	 '{ 37, 42 },	
 '{ 37, 42 },	 '{ 37, 42 },	 '{ 37, 42 },	 '{ 38, 43 },	
 '{ 0, 0 },	 '{ 38, 43 },	 '{ 0, 0 },	 '{ 0, 0 },	
 '{ 38, 44 },	 '{ 38, 44 },	 '{ 38, 44 },	 '{ 38, 44 },	
 '{ 38, 44 },	 '{ 38, 44 },	 '{ 38, 44 },	 '{ 38, 44 },	
 '{ 38, 44 },	 '{ 38, 44 },	 '{ 43, 44 },	 '{ 43, 44 },	
 '{ 43, 44 },	 '{ 43, 44 },	 '{ 43, 44 },	 '{ 43, 44 },	
 '{ 43, 44 },	 '{ 43, 44 },	 '{ 43, 44 },	 '{ 43, 44 },	
 '{0, 0}};

YYSvf yysvec[] = '{
 '{ 0, 0, 0 },
 '{ 1, 0, 0 },
  /* state 0 */ '{ 0, 1, 0 },
  /* state 1 */ '{ -3, 0, 0 },
  /* state 2 */ '{ -19, 3, 0 },
  /* state 3 */ '{ 0, 1, 0 },
  /* state 4 */ '{ 0, 1, 0 },
  /* state 5 */ '{ 0, 1, 0 },
  /* state 6 */ '{ 0, 1, 0 },
  /* state 7 */ '{ 0, 1, 0 },
  /* state 8 */ '{ 0, 1, 0 },
  /* state 9 */ '{ 0, 1, 0 },
  /* state 10 */ '{ 0, 1, 0 },
  /* state 11 */ '{ 0, 1, 0 },
  /* state 12 */ '{ 0, 1, 0 },
  /* state 13 */ '{ 0, 0, 1 },
  /* state 14 */ '{ 0, 0, 3 },
  /* state 15 */ '{ 0, 0, 5 },
  /* state 16 */ '{ 0, 0, 8 },
  /* state 17 */ '{ -31, 0, 11 },
  /* state 18 */ '{ 32, 0, 13 },
  /* state 19 */ '{ 0, 0, 15 },
  /* state 20 */ '{ 3, 0, 18 },
  /* state 21 */ '{ 44, 20, 21 },
  /* state 22 */ '{ 0, 0, 24 },
  /* state 23 */ '{ 0, 0, 27 },
  /* state 24 */ '{ 0, 0, 30 },
  /* state 25 */ '{ 1, 0, 33 },
  /* state 26 */ '{ 1, 0, 35 },
  /* state 27 */ '{ 1, 0, 37 },
  /* state 28 */ '{ 0, 0, 39 },
  /* state 29 */ '{ 0, 0, 42 },
  /* state 30 */ '{ -1, 19, 0 },
  /* state 31 */ '{ 0, 0, 45 },
  /* state 32 */ '{ 33, 0, 0 },
  /* state 33 */ '{ 0, 22, 47 },
  /* state 34 */ '{ 51, 20, 49 },
  /* state 35 */ '{ 105, 0, 0 },
  /* state 36 */ '{ 120, 0, 0 },
  /* state 37 */ '{ 1, 0, 0 },
  /* state 38 */ '{ 6, 0, 0 },
  /* state 39 */ '{ 3, 0, 0 },
  /* state 40 */ '{ 1, 37, 51 },
  /* state 41 */ '{ 130, 0, 0 },
  /* state 42 */ '{ 0, 43, 53 },
  /* state 43 */ '{ 1, 0, 0 },
  /* state 44 */ '{ 9, 0, 0 },
  /* state 45 */ '{ 2, 0, 0 },
  /* state 46 */ '{ 5, 0, 0 },
  /* state 47 */ '{ 0, 0, 55 },
  /* state 48 */ '{ 0, 0, 57 },
  /* state 49 */ '{ 0, 0, 59 },
  /* state 50 */ '{ 0, 0, 0}
};

int yytop_ptr = 187;
//int yybgin_ptr = 1;
byte unsigned yymatch[] = {
  0,   1,   1,   1,   1,   1,   1,   1, 
  1,   9,  10,   1,   9,   9,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  9,   1,  34,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
 48,  48,  48,  48,  48,  48,  48,  48, 
 48,  48,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,  34,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
  1,   1,   1,   1,   1,   1,   1,   1, 
0 };

byte unsigned yyextra[] = {
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
 0 };

`define NLSTATE yyprevious = `YYNEWLINE

int yylstate[`YYLMAX];

int yylstate_ptr, yylsp_ptr, yyolsp_ptr;

int yyfnd_ptr;
int yyestate_ptr;
int yyprevious = `YYNEWLINE;

task allprint(byte c);
  case(c)
    "\n": $write("\\n");
    "\t": $write("\\t");
    "\b": $write("\\b");
    " " : $write("\\\bb");
    default: $write($psprintf("%s",c));
  endcase
  return;
endtask

task sprint(string pc);
  $write($psprintf("%s", pc));
endtask

function int yylook();
  int yystate_ptr, lsp_ptr;
  int yyt_ptr;
  int yyz_ptr;
  byte unsigned yych;
  int yyfirst;
  int yyr_ptr;

  int debug;

  int yylastch_ptr;

  /* start off machines */
`ifdef LEXDEBUG
  debug = 1;
`endif

  yyfirst = 1;

  if (!yymorfg) begin
    yylastch_ptr = 0;
    //yytext = {};
  end
  else begin
    yymorfg = 0;
    yylastch_ptr = yyleng;
  end

  forever begin
`ifdef LEXDEBUG
    $write ("\n\nouter yylastch_ptr = %0d yyleng = %0d yytext[0] = %0d\n", yylastch_ptr, yyleng, yytext[0]);
`endif
    lsp_ptr = 0;

    yyestate_ptr = yybgin_ptr;
    yystate_ptr = yybgin_ptr;

    if (yyprevious == `YYNEWLINE) yystate_ptr++;

    forever begin
      automatic bit tryagain = 0;
      automatic bit contin = 0;

`ifdef LEXDEBUG
      if (debug) $write ($psprintf("state %0d\n", yystate_ptr - 1));
`endif

      yyt_ptr = yysvec[yystate_ptr].yystoff_ptr;

      if (yyt_ptr == 0 && !yyfirst) begin  /* may not be any transitions */
`ifdef LEXDEBUG
        $write ("\n\nbreaking\n");
`endif
        yyz_ptr = yysvec[yystate_ptr].yyother_ptr;
        if (yyz_ptr == 0) break;
        if (yysvec[yyz_ptr].yystoff_ptr == 0) break;
      end

      yych = lex_input();
      begin
        yytext[yylastch_ptr]  = yych;
`ifdef LEXDEBUG
        $write("yytext: %p\n", yytext);
        $write("yytext: %s\n", string'(yytext));
`endif
      end
      yylastch_ptr++;

`ifdef LEXDEBUG
      $write("len: %0d yych = %0d yytext: %s yylastch_ptr: %0d\n", yytext.size(), yych, string'(yytext), yylastch_ptr);
`endif

      if (yylastch_ptr > `YYLMAX) begin
        $write($psprintf("Input string too long, limit %d\n", `YYLMAX));
        $fatal(1);
      end
      yyfirst = 0;

      do begin : try_again
        contin = 0;
`ifdef LEXDEBUG
        if (debug) begin
          $write("char ");
          allprint(yych);
          $write("\n");
        end
        $write("yyt = %0d yyr = %0d yytop = %0d yytext = %s\n", yyt_ptr, yyr_ptr, yytop_ptr, string'(yytext));
`endif
        yyr_ptr = yyt_ptr;
        if ( yyt_ptr > 0) begin
          yyt_ptr = yyr_ptr + yych;
`ifdef LEXDEBUG
          $write(">yyt = %0d yytop = %0d yystate = %0d\n", yyt_ptr, yytop_ptr, yystate_ptr);
`endif
          if (yyt_ptr <= yytop_ptr && yycrank[yyt_ptr].verify == yystate_ptr) begin
            if (yycrank[yyt_ptr].advance == `YYLERR) begin   /* error transitions */
`ifdef LEXDEBUG
              $write(">unput\n");
`endif
              `unput(yytext[--yylastch_ptr]);
              break;
            end
            yystate_ptr = yycrank[yyt_ptr].advance;
            yylstate[lsp_ptr++] = yystate_ptr;
`ifdef LEXDEBUG
            $write("yystate = %0d\n", yystate_ptr);
`endif
            if (lsp_ptr > `YYLMAX) begin
              $write($psprintf("Input string too long, limit %d\n", `YYLMAX));
              $fatal(1);
            end
`ifdef LEXDEBUG
            if (debug) begin
              $write( $psprintf("+\nstate %0d char ", yystate_ptr - 1));
              allprint(yych);
              $write("\n");
            end
`endif
            contin = 1;
            break;
          end
        end
        else if (yyt_ptr < 0) begin    /* r < yycrank */
          yyr_ptr = -1 * yyt_ptr;
          yyt_ptr = yyr_ptr;
`ifdef LEXDEBUG
          if (debug) $write("compressed state\n");
`endif
          yyt_ptr = yyt_ptr + yych;
`ifdef LEXDEBUG
          $write("yyt = %0d yyr = %0d\n", yyt_ptr, yyr_ptr);
`endif
          if (yyt_ptr <= yytop_ptr && yycrank[yyt_ptr].verify == yystate_ptr) begin
            if (yycrank[yyt_ptr].advance == `YYLERR) begin    /* error transitions */
`ifdef LEXDEBUG
              $write(">>unput\n");
`endif
              `unput(yytext[--yylastch_ptr]);
              break;
            end
            yystate_ptr = yycrank[yyt_ptr].advance;
            yylstate[lsp_ptr++] = yystate_ptr;
            if (lsp_ptr > `YYLMAX) begin
              $write($psprintf("Input string too long, limit %d\n", `YYLMAX));
              $fatal(1);
            end
`ifdef LEXDEBUG
            if (debug) begin
              $write( $psprintf("++\nstate %0d char ", yystate_ptr - 1));
              allprint(yych);
              $write("\n");
            end
`endif
            contin = 1;
            break;
          end
          yyt_ptr = yyr_ptr + yymatch[yych];
`ifdef LEXDEBUG
          if (debug) begin
            $write ("try fall back character ");
            allprint(yymatch[yych]);
            $write("\n");
          end
          $write("yyt = %0d yyr = %0d\n", yyt_ptr, yyr_ptr);
`endif
          if (yyt_ptr <= yytop_ptr && yycrank[yyt_ptr].verify == yystate_ptr) begin
            if (yycrank[yyt_ptr].advance == `YYLERR) begin   /* error transition */
`ifdef LEXDEBUG
              $write(">>>unput\n");
`endif
              `unput(yytext[--yylastch_ptr]);
              break;
            end
            yystate_ptr = yycrank[yyt_ptr].advance;
            yylstate[lsp_ptr++] = yystate_ptr;
            if (lsp_ptr > `YYLMAX) begin
              $write($psprintf("Input string too long, limit %d\n", `YYLMAX));
              $fatal(1);
            end
`ifdef LEXDEBUG
            if (debug) begin
              $write( $psprintf("+++\nstate %0d char ", yystate_ptr - 1));
              allprint(yych);
              $write("\n");
            end
`endif
            contin = 1;
            break;
          end
        end
        yystate_ptr = yysvec[yystate_ptr].yyother_ptr;
        if (yystate_ptr)
          yyt_ptr = yysvec[yystate_ptr].yystoff_ptr;
        tryagain = yystate_ptr && yyt_ptr;

        if (tryagain) begin
`ifdef LEXDEBUG
          if(debug) $write($psprintf("fall back to state %0d\n", yystate_ptr - 1));
          $write("--yyt = %0d yyr = %0d\n", yyt_ptr, yyr_ptr);
`endif
        end
      end while(tryagain);
 
      if (contin) begin
`ifdef LEXDEBUG
        $write("here\n")
`endif
        ;
      end else begin
`ifdef LEXDEBUG
        $write(">>>>unput\n");
`endif
        `unput(yytext[--yylastch_ptr]);
        b.Bungetc();
        break;
      end
    end
`ifdef LEXDEBUG
    if (debug) begin
      $write($psprintf("stopped at %0d with ", yylstate[lsp_ptr - 1] - 1));
      allprint(yych);
      $write("\n");
    end
    $write($psprintf("lsp: %0d\n", lsp_ptr));
`endif
    while (lsp_ptr-- > 0) begin
      yytext[yylastch_ptr--] = 0;
`ifdef LEXDEBUG
      $write($psprintf("lsp: %0d yyfnd: %0d next yyfnd: %0d yytext: %s\n", lsp_ptr, yyfnd_ptr, yysvec[yylstate[lsp_ptr]].yystops_ptr, string'(yytext)));
`endif
      if (yylstate[lsp_ptr] != 0)
        yyfnd_ptr = yysvec[yylstate[lsp_ptr]].yystops_ptr;
      if (yyfnd_ptr > 0) begin
        yyolsp_ptr = lsp_ptr;
`ifdef LEXDEBUG
        $write($psprintf("yyextra[%0d] = %0d\n", yyvstop[yyfnd_ptr], yyextra[yyvstop[yyfnd_ptr]]));
`endif
        if (yyextra[yyvstop[yyfnd_ptr]]) begin        /* must backup */
          while(yyback(yysvec[yylstate[lsp_ptr]].yystops_ptr, -1 * yyfnd_ptr) != 1 && lsp_ptr > 0)begin
            lsp_ptr--;
`ifdef LEXDEBUG
            $write(">>>>>unput\n");
`endif
            `unput(yytext[yylastch_ptr--]);
          end
        end
        yyprevious = yytext[yylastch_ptr];
        yylsp_ptr = lsp_ptr;
        yyleng = yylastch_ptr + 1;
        yytext = yytext[0:yyleng - 1];
`ifdef LEXDEBUG
        if(debug) begin
          $write("\nmatch ");
          $write(" (yyleng: %0d, yylastch_ptr: %0d) ", yyleng, yylastch_ptr);
          $write("%s", string'(yytext));
          $write($psprintf(" action %0d\n\n", yyvstop[yyfnd_ptr]));
        end
`endif
        return(yyvstop[yyfnd_ptr++]); // XXX
      end
`ifdef LEXDEBUG
      $write(">>>>>>unput\n");
`endif
      `unput(yytext[yylastch_ptr]);
    end
    if (yytext[0] == 0  /* && feof(yyin) */)
    begin
      if(debug) $write("Exiting\n");
      return(0);
    end
    yyprevious = lex_input();
    yytext[0] = yyprevious;
    if (yyprevious > 0)
      `lex_output(yyprevious);
    yytext = {};
    yylastch_ptr = 0;
`ifdef LEXDEBUG
    if(debug) $write("\n");
`endif
  end
endfunction

function int yyback(int p, int m);
  if (yyvstop[p]==0) return(0);
  while (yyvstop[p]) begin
    if (yyvstop[p++] == m)
      return(1);
  end
  return(0);
endfunction

/* the following are only used in the lex library */
function int yyinput();
  return(lex_input());
endfunction

task  yyoutput(int c);
  `lex_output(c);
endtask

task yyunput(int c);
  `unput(c);
endtask

`ifdef MAIN
initial begin
  string filename;
  int tok;

  if ($value$plusargs("input=%s", filename))
    b = Bopen(filename, `OREAD);

  $write("\n");
  initialize_lexer(0);
  tok = yylex();
  while(tok) begin
    $write($psprintf("token: %0d\n", tok));
    tok = yylex();
  end
  $write($psprintf("token: %0d\n", tok));
  $write("\n");
end
endmodule
`endif
