program automatic test;

  initial begin : prog
    automatic json_pkg::Val_ val;
    automatic string filename = "test.json";
    automatic string json_str = "\n\n{\n\n \"z\" : null,\n\"y\" : [],\n\n  \"x\" : {},\n\n\n \"a\" : [ -9223372036854775808, {\"2\" : {\"a\": [1.000005]}}, \"array_added_text\" ],\n \"f\" : false, \"i\" : 1, \"n\" : null,\n \"o\" : { \"2\" : 2, \"3\" : [3,4,5],\n \"inner_obj\" : { \"auth\" : \"zcr\", \"grade\" : 5 } }\n , \"s\" : \"abc\", \"t\" : true }          \n";

    if ($value$plusargs("input=%s", filename))
      $display(json_pkg::pJSON(filename).convert2string());

    $display("Parsing json string %s\n", json_str);
    val = json_pkg::psJSON(json_str);
    $display(val.convert2string());
    $display(val.getByKey("o").convert2string());
  end
endprogram
