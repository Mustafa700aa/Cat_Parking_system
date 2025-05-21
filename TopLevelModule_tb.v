`timescale 1ns / 1ps

module TopLevelModule_tb;
    // تعريف الإشارات
    reg clk_tb;
    reg reset_tb;
    reg entry_tb;
    reg exit_tb;
    reg [3:0] car_id_tb;
    wire write_enable;
    wire read_enable;
    wire [31:0] Entry_time;
    wire [31:0] Ccost;

    // مثيل وحدة TopLevelModule
    TopLevelModule uut (
        .clk(clk_tb),
        .reset(reset_tb),
        .entry(entry_tb),
        .exit(exit_tb), // تصحيح: توصيل exit_tb بدل entry_tb
        .car_id(car_id_tb),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .Entry_time(Entry_time),
        .Ccost(Ccost)
    );

    // توليد الساعة
    always begin
        #500 clk_tb = ~clk_tb; // فترة الساعة 1000 نانوثانية
    end

    // سيناريو الاختبار
    initial begin
        // تهيئة الإشارات
        clk_tb = 0;
        reset_tb = 1;
        entry_tb = 0;
        exit_tb = 0;
        car_id_tb = 0;

        // إلغاء الريست بعد 1000 نانوثانية
        #1000 reset_tb = 0;

        // دخول السيارة 1
        #1000 entry_tb = 1; car_id_tb = 1; // تفعيل إشارة الدخول
        #1000 entry_tb = 0; // إلغاء تفعيل إشارة الدخول

        // انتظار للسماح بتحديث current_time
        #5000;

        // خروج السيارة 1
        #1000 exit_tb = 1; // تفعيل إشارة الخروج
        #1000 exit_tb = 0; // إلغاء تفعيل إشارة الخروج

        // انتظار لمراقبة المخرجات
        #5000;

        // إنهاء المحاكاة
        #20000 $finish;
    end

    // مراقبة الإشارات
    initial begin
        $monitor("Time=%0t: reset_tb=%b, entry_tb=%b, exit_tb=%b, car_id_tb=%0d, write_enable=%b, read_enable=%b, Entry_time=%0d, Ccost=%0d",
                 $time, reset_tb, entry_tb, exit_tb, car_id_tb, write_enable, read_enable, Entry_time, Ccost);
    end
endmodule