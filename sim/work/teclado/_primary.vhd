library verilog;
use verilog.vl_types.all;
entity teclado is
    port(
        reset_in        : in     vl_logic;
        clock_in        : in     vl_logic;
        coluna_in       : in     vl_logic_vector(2 downto 0);
        linha_in        : in     vl_logic_vector(2 downto 0);
        numgiro_out     : out    vl_logic_vector(3 downto 0)
    );
end teclado;
