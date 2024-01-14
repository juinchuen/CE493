clear;
clc;

figure;

subplot(1,3,1);

a = readtable("svm_test_a.csv");

a = removevars(a, "Var81");

a = table2array(a);

surf(a);

subplot(1,3,2);

a = readtable("svm_test_b.csv");

a = removevars(a, "Var81");

a = table2array(a);

surf(a);

subplot(1,3,3);

a = readtable("svm_test_c.csv");

a = removevars(a, "Var81");

a = table2array(a);

surf(a);