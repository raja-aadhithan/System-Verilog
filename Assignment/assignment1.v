//question 1 without method
module sort();
class AB;
rand int da[];
constraint da_val{da.size == 10;
                     foreach(da[i]) da[i] inside {[0:100]};}
function void post_randomize();
$display("before sorting %p",da);
for(int i =0; i<10; i++)
begin
for(int j = i+1; j<10; j++)
        if(da[i] > da[j])
        begin
                da[i] = da[i] + da[j];
                da[j] = da[i] - da[j];
                da[i] = da[i] - da[j];
        end
end
$display("after sorting %p",da);
endfunction
endclass

AB a_h = new();
initial begin
void'(a_h.randomize());
end

endmodule

//question 1 with method

module sort_array();
class AB;
rand int da[];
constraint da_val{da.size == 10;
                     foreach(da[i]) da[i] inside {[0:100]};}
function void post_randomize();
$display("before sorting %p",da);
for(int i =0; i<10; i++)
da.sort();
$display("after sorting %p",da);
endfunction

endclass

AB a_h = new();
initial begin
void'(a_h.randomize());
end

endmodule

//question2 with and without method

module queue();

int q1[$] = {1,22,13,1,14,15};
int q2[$] = {2,5,1,4,3};
int q3[$] = {60,44};

initial begin
$display("original q1 of size %0d is %p",q1.size,q1);
$display("original q2 of size %0d is %p",q2.size,q2);
$display("original q3 of size %0d is %p",q3.size,q3);
q1 = {q1[0:1],q2,q1[2:$]};
$display("q1 after 1st method of size %0d is %p",q1.size,q1);
foreach (q3[i]) q1.insert(q1.size,q3[i]);
$display("q1 after 2nd method of size %0d is %p",q1.size,q1);
end
endmodule

//question3

module pop();
int q1[$]= { 2,2,2,3,3,4,44,3,2,13,33,564,6,5,23,2,76,4,6,8};
int x;
initial begin
        foreach(q1[i]) begin
                x = q1.pop_front();
        end
        if(q1.size != 0) $display("foreach cant be used for popping all the elements");
end
endmodule

//question4

the next value will make a call to the first value as in a cycle;

//question5

i_num1 = 8;
i_num2 = 1;