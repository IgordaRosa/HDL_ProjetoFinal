library verilog;
use verilog.vl_types.all;
entity display7seg is
    port(
        reset_in        : in     vl_logic;
        clock_in        : in     vl_logic;
        numgiro_in      : in     vl_logic_vector(3 downto 0);
        seg_out         : out    vl_logic_vector(6 downto 0)
    );
end display7seg;
