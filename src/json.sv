class Val_;
    local Val_ member;

    virtual function automatic bit isObject(); return 0; endfunction
    virtual function automatic bit isArray(); return 0; endfunction
    virtual function automatic bit isTrue(); return 0; endfunction
    virtual function automatic bit isNull(); return 0; endfunction
    virtual function automatic string asString(); return ""; endfunction
    virtual function automatic int asInt(); return 0; endfunction
    virtual function automatic real asReal(); return 0.0; endfunction
    virtual function automatic int unsigned size(); return 0; endfunction

    virtual function automatic Val_ getByIndex (input int unsigned index);
        return null;
    endfunction
    virtual function string convert2string();
        return this.asString();
    endfunction
endclass

class ObjectVal_ extends Val_;
    local Val_ members[string];

    function new (); super.new(); endfunction

    function automatic void append (input string key, input Val_ elem);
        members[key] = elem;
    endfunction

    virtual function automatic Val_ getByKey (input string key);
        if (members.exists(key)) begin
          return members[key];
        end
        return null;
    endfunction

    virtual function string asString();
        string s = "{ ";
        string t;

        if ( members.first(t)) do
        begin
            $sformat(s, "%s%s : %s, ", s, t, members[t].convert2string());
        end
        while (members.next(t));
        $sformat(s, "%s} ", s);
        return s;
    endfunction
endclass

class ArrayVal_ extends Val_;
    local Val_ members[$];

    function new (); super.new(); endfunction
    function automatic void append (input Val_ elem); members.push_back(elem); endfunction
    virtual function automatic bit isArray(); return 1; endfunction
    virtual function automatic int unsigned size(); return members.size(); endfunction

    virtual function automatic Val_ getByIndex (input int unsigned index);
        if (members.size()) begin
            return members[index];
        end
        return null;
    endfunction

    virtual function string asString();
        string s = "[ ";
        int i;
        for (i = 0; i < members.size(); i++)
        begin
            $sformat(s, "%s%s, ", s, members[i].convert2string());
        end
        $sformat(s, "%s]", s);
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
    virtual function string convert2string(); if (m_bool) return "true"; else return "false"; endfunction
endclass

class NullVal_ extends Val_;
    function new(); super.new(); endfunction
    virtual function automatic bit isNull(); return 1; endfunction
    virtual function string asString(); return "null"; endfunction
endclass

class NumberVal_ extends Val_;
    local real m_number;

    function new (input real num = 0.0);
        super.new();
        m_number = num;
   endfunction

    virtual function automatic int asInt(); return int'(m_number); endfunction
    virtual function automatic real asReal(); return m_number; endfunction
    virtual function string asString(); return $psprintf("%0f", m_number); endfunction
endclass

class StringVal_ extends Val_;
    local string m_string;

    function new ( input string s = "");
        super.new();
        m_string = s;
    endfunction

    virtual function string asString(); return m_string; endfunction
endclass
