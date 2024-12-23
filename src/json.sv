class Val_;
    local Val_ member;

    virtual function automatic bit isObject(); return 0; endfunction
    virtual function automatic bit isArray(); return 0; endfunction
    virtual function automatic bit isTrue(); return 0; endfunction
    virtual function automatic bit isNull(); return 0; endfunction
    virtual function automatic bit isNumber(); return 0; endfunction

    virtual function automatic string asString(); return ""; endfunction
    virtual function automatic longint asInt(); return 0; endfunction
    virtual function automatic real asReal(); return 0.0; endfunction

    virtual function automatic int unsigned size(); return 0; endfunction

    virtual function automatic Val_ getByIndex (input int unsigned index);
        return null;
    endfunction

    virtual function automatic Val_ getByKey (input string key);
        return null;
    endfunction

    virtual function string convert2string();
        return this.asString();
    endfunction
endclass

class ObjectVal_ extends Val_;
    local Val_ members[string];
    local string order[$];

    function new (); super.new(); endfunction

    function automatic void append (input string key, input Val_ elem);
        members[key] = elem;
        order.push_back(key);
    endfunction

    function automatic Val_ getByKey (input string key);
        if (members.exists(key))
          return members[key];
        return null;
    endfunction

    function automatic Val_ getByIndex (input int unsigned index);
        if (members.num())
            return members[order[index]];
        return null;
    endfunction

    function automatic int unsigned size(); return order.size(); endfunction

    function string asString();
        string s = "{ ";
        int i;
        if (order.size() == 0)
            return "{}";
        for (i = 0; i < order.size() - 1; i++)
            $sformat(s, "%s\"%s\" : %s, ", s, order[i], members[order[i]].convert2string());
        $sformat(s, "%s\"%s\" : %s }", s, order[i], members[order[order.size() - 1]].convert2string());
        return s;
    endfunction
endclass

class ArrayVal_ extends Val_;
    local Val_ members[$];

    function new (); super.new(); endfunction
    function automatic void append (input Val_ elem); members.push_back(elem); endfunction
    function automatic bit isArray(); return 1; endfunction
    function automatic int unsigned size(); return members.size(); endfunction

    function automatic Val_ getByIndex (input int unsigned index);
        if (members.size())
            return members[index];
        return null;
    endfunction

    function string asString();
        string s = "[ ";
        int i;
        if (members.size() == 0)
            return "[]";
        for (i = 0; i < members.size() - 1; i++)
            $sformat(s, "%s%s, ", s, members[i].convert2string());
        $sformat(s, "%s%s ]", s, members[members.size() - 1].convert2string());
        return s;
    endfunction

endclass

class BoolVal_ extends Val_;
    local bit m_bool;

    function new(input bit b = 0);
        super.new();
        m_bool = b;
    endfunction

    function automatic bit isTrue(); return m_bool; endfunction
    function string convert2string(); if (m_bool) return "true"; else return "false"; endfunction
endclass

class NullVal_ extends Val_;
    function new(); super.new(); endfunction
    function automatic bit isNull(); return 1; endfunction
    function string asString(); return "null"; endfunction
endclass

class RealVal_ extends Val_;
    local real m_number;

    function new (input real num = 0.0);
        super.new();
        m_number = num;
   endfunction

    function automatic bit isNumber(); return 1; endfunction
    function automatic longint asInt(); return longint'(m_number); endfunction
    function automatic real asReal(); return m_number; endfunction
    function string asString(); return $psprintf("%f", m_number); endfunction
endclass

class IntVal_ extends Val_;
    local longint m_number;

    function new (input longint num = 0.0);
        super.new();
        m_number = num;
   endfunction

    function automatic bit isNumber(); return 1; endfunction
    function automatic longint asInt(); return m_number; endfunction
    function automatic real asReal(); return real'(m_number); endfunction
    function string asString(); return $psprintf("%0d", m_number); endfunction
endclass

class StringVal_ extends Val_;
    local string m_string;

    function new ( input string s = "");
        super.new();
        m_string = s;
    endfunction

    function string asString(); return m_string; endfunction
endclass
