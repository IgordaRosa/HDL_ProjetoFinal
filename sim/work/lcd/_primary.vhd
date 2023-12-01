library verilog;
use verilog.vl_types.all;
entity lcd is
    port(
        reset_in        : in     vl_logic;
        clock_in        : in     vl_logic;
        numgiro_in      : in     vl_logic_vector(3 downto 0);
        lcd_out         : out    vl_logic_vector(7 downto 0);
        enlcd_out       : out    vl_logic;
        rslcd_out       : out    vl_logic;
        rwlcd_out       : out    vl_logic
    );
end lcd;
