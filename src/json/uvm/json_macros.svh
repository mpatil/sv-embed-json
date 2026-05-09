// vim: ft=systemverilog
//
// UVM-aware reader / writer macros over sv-embed-json's `Val_` tree.
//
// Optional layer: include from a UVM-using testbench (or generated SV class
// hierarchy) where `uvm_error` is in scope. The non-UVM core in
// json/json_pkg.sv has no dependency on UVM and these macros are not
// included by it.
//
// Convention:
//   `from_json_<kind>(FIELD, KEY[, EXTRA])`
//   `to_json_<kind>(FIELD, KEY[, EXTRA])`
// where FIELD is the SV lvalue / source expression (typically `m_<name>`
// or similar), KEY is the bare JSON object key (no quotes), and any
// EXTRA is the typedef name when the macro needs it (enum / object_sub /
// oneof).
//
// All macros assume:
//   * a `Val_ jv` (or `ObjectVal_ jv`, depending on direction) is in scope,
//   * `mkInt` / `mkReal` / `mkStr` / `mkBool` from json_pkg are visible
//     unqualified (e.g. via `import json_pkg::*;` in the surrounding
//     package),
//   * `Val_`, `ObjectVal_`, `ArrayVal_`, `StringVal_`, `IntVal_`,
//     `BoolVal_` are likewise visible.

`ifndef SV_EMBED_JSON_UVM_MACROS_SVH
`define SV_EMBED_JSON_UVM_MACROS_SVH


// -- read side -------------------------------------------------------------

`define from_json_string(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null) \
        FIELD = jv.getByKey(`"KEY`").asString();

`define from_json_string_array(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) \
          FIELD[i] = _arr.getByIndex(i).asString(); \
      end

`define from_json_int(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isNumber()) \
        FIELD = jv.getByKey(`"KEY`").asInt();

`define from_json_int_array(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) \
          FIELD[i] = _arr.getByIndex(i).asInt(); \
      end

`define from_json_bool(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null) \
        FIELD = jv.getByKey(`"KEY`").isTrue();

`define from_json_bool_array(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) \
          FIELD[i] = _arr.getByIndex(i).isTrue(); \
      end

`define from_json_hex(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null) \
        void'($sscanf(jv.getByKey(`"KEY`").asString(), "0x%h", FIELD));

`define from_json_hex_array(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) \
          void'($sscanf(_arr.getByIndex(i).asString(), "0x%h", FIELD[i])); \
      end

`define from_json_binary(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null) \
        void'($sscanf(jv.getByKey(`"KEY`").asString(), "0b%b", FIELD));

`define from_json_binary_array(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) \
          void'($sscanf(_arr.getByIndex(i).asString(), "0b%b", FIELD[i])); \
      end

`define from_json_enum(FIELD, KEY, TYPE) \
      if (jv.getByKey(`"KEY`") != null) begin \
        string _s = jv.getByKey(`"KEY`").asString(); \
        void'(TYPE``_wrapper::from_name(_s, FIELD)); \
        if (FIELD.name() != _s) \
          $error($sformatf(`"Simulator Error: enum field KEY of TYPE; from_name: %s name: %s`", FIELD.name(), _s)); \
      end else \
        $error(`"enum KEY of TYPE Error`");

`define from_json_enum_array(FIELD, KEY, TYPE) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) begin \
          string _s = _arr.getByIndex(i).asString(); \
          void'(TYPE``_wrapper::from_name(_s, FIELD[i])); \
          if (FIELD[i].name() != _s) \
            $error($sformatf(`"Simulator Error: enum field array KEY of TYPE; from_name: %s name: %s`", FIELD[i].name(), _s)); \
        end \
      end

`define from_json_object(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isObject()) begin \
        if (null == FIELD) \
          FIELD = new("", this); \
        FIELD.fromJSON(jv.getByKey(`"KEY`")); \
      end

`define from_json_object_array(FIELD, KEY) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) begin \
          FIELD[i] = new("", this); \
          FIELD[i].fromJSON(_arr.getByIndex(i)); \
        end \
      end

`define from_json_oneof(FIELD, KEY, BASE) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isObject()) \
        FIELD = BASE``::fromJSONFactory(jv.getByKey(`"KEY`"));

`define from_json_oneof_array(FIELD, KEY, BASE) \
      if (jv.getByKey(`"KEY`") != null && jv.getByKey(`"KEY`").isArray()) begin \
        Val_ _arr = jv.getByKey(`"KEY`"); \
        FIELD = new [_arr.size()] (FIELD); \
        for (int i = 0; i < _arr.size(); i++) \
          FIELD[i] = BASE``::fromJSONFactory(_arr.getByIndex(i)); \
      end


// -- write side ------------------------------------------------------------

`define to_json_string(FIELD, KEY) \
      jv.append(`"KEY`", mkStr(FIELD));

`define to_json_string_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) \
          _arr.append(mkStr(FIELD[i])); \
        jv.append(`"KEY`", _arr); \
      end

`define to_json_int(FIELD, KEY) \
      jv.append(`"KEY`", mkInt(FIELD));

`define to_json_int_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) \
          _arr.append(mkInt(FIELD[i])); \
        jv.append(`"KEY`", _arr); \
      end

`define to_json_bool(FIELD, KEY) \
      jv.append(`"KEY`", mkBool(FIELD));

`define to_json_bool_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) \
          _arr.append(mkBool(FIELD[i])); \
        jv.append(`"KEY`", _arr); \
      end

`define to_json_hex(FIELD, KEY) \
      begin \
        string _s; \
        _s.hextoa(FIELD); \
        jv.append(`"KEY`", mkStr({"0x", _s})); \
      end

`define to_json_hex_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) begin \
          string _s; \
          _s.hextoa(FIELD[i]); \
          _arr.append(mkStr({"0x", _s})); \
        end \
        jv.append(`"KEY`", _arr); \
      end

`define to_json_binary(FIELD, KEY) \
      begin \
        string _s; \
        _s.bintoa(FIELD); \
        jv.append(`"KEY`", mkStr({"0b", _s})); \
      end

`define to_json_binary_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) begin \
          string _s; \
          _s.bintoa(FIELD[i]); \
          _arr.append(mkStr({"0b", _s})); \
        end \
        jv.append(`"KEY`", _arr); \
      end

`define to_json_enum(FIELD, KEY) \
      jv.append(`"KEY`", mkStr(FIELD.name()));

`define to_json_enum_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) \
          _arr.append(mkStr(FIELD[i].name())); \
        jv.append(`"KEY`", _arr); \
      end

`define to_json_object(FIELD, KEY) \
      jv.append(`"KEY`", FIELD.toJSON());

`define to_json_object_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) \
          _arr.append(FIELD[i].toJSON()); \
        jv.append(`"KEY`", _arr); \
      end

`define to_json_oneof(FIELD, KEY) \
      if (FIELD != null) jv.append(`"KEY`", FIELD.toJSON());

`define to_json_oneof_array(FIELD, KEY) \
      begin \
        ArrayVal_ _arr = new(); \
        foreach (FIELD[i]) \
          if (FIELD[i] != null) \
            _arr.append(FIELD[i].toJSON()); \
        jv.append(`"KEY`", _arr); \
      end


`endif // SV_EMBED_JSON_UVM_MACROS_SVH
