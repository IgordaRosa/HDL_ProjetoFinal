library verilog;
use verilog.vl_types.all;
entity vendingmachine is
    port(
        reset_in        : in     vl_logic;
        clock_in        : in     vl_logic;
        coluna_in       : in     vl_logic_vector(2 downto 0);
        linha_in        : in     vl_logic_vector(3 downto 0);
        sensor1_in      : in     vl_logic;
        sensor2_in      : in     vl_logic;
        rele_out        : out    vl_logic;
        lcd_out         : out    vl_logic_vector(7 downto 0);
        enlcd_out       : out    vl_logic;
        rslcd_out       : out    vl_logic;
        rwlcd_out       : out    vl_logic
    );
end vendingmachine;
