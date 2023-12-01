library verilog;
use verilog.vl_types.all;
entity rele is
    port(
        reset_in        : in     vl_logic;
        clock_in        : in     vl_logic;
        numgiro_in      : in     vl_logic_vector(3 downto 0);
        contador_giro_out: out    vl_logic_vector(3 downto 0);
        sensor1_in      : in     vl_logic;
        sensor2_in      : in     vl_logic;
        rele_out        : out    vl_logic
    );
end rele;
