create database project_bank;
use project_bank;

drop database project_bank;
alter table finance_1
modify column issue_d date;
describe finance_1;

set sql_safe_updates = 0;
delete from finance_2 where last_pymnt_d = 0 or last_credit_pull_d = 0;
alter table finance_2
modify column earliest_cr_line date;
alter table finance_2
modify column last_pymnt_d date;
alter table finance_2
modify column last_credit_pull_d date;
describe finance_2;
set sql_safe_updates = 1;

#1 Year wise loan amount stats

drop table if exists kpi1;
create table kpi1
select year(f1.issue_d) as year, f1.loan_status as loan_status, sum(f1.loan_amnt) as total_loan_amount
from project_bank.table_1 f1
group by year, loan_status 
order by year, loan_status;

select * from kpi1;

#2 Grade and sub grade wise revol_bal

drop table if exists kpi2;
create table kpi2
select grade, sub_grade, sum(revol_bal) as total_revol_balance
from table_1 join finance_2
on table_1.id = finance_2.id
group by 1,2
order by 2;

select * from kpi2;

#3 Total Payment for Verified Status Vs Total Payment for Non Verified Status

drop table if exists kpi3;
create table kpi3
select verification_status, round(sum(total_pymnt), 2) as total_pymnt
from table_1 join finance_2
on table_1.id = finance_2.id
group by verification_status;

select * from kpi3;

#4 State wise and last_credit_pull_d wise loan status

drop table if exists kpi4;
create table kpi4
select addr_state as state, year(last_credit_pull_d) as last_credit_pull_date_year, loan_status
from table_1 join finance_2
on table_1.id = finance_2.id
group by 1,2,3
order by 1,2,3;

select * from kpi4;

#5 Home ownership Vs last payment date stats

drop table if exists kpi5;
create table kpi5
select table_1.id as id, year(last_pymnt_d) as last_payment_date_year, home_ownership,round(sum(total_pymnt),2) as total_payment
from table_1 join finance_2
on table_1.id = finance_2.id
group by 1,2,3
order by 1,2;

select * from kpi5; 

#6 Average of revol_bal by grade

drop table if exists kpi6;
create table kpi6
select grade, round(avg(revol_bal),2) as avg_revol_balance
from table_1 join finance_2
on table_1.id = finance_2.id
group by 1
order by 1,2;

select * from kpi6;

#7 Average of loan_amnt by loan_status

drop table if exists kpi7;
create table kpi7
select loan_status, round(avg(loan_amnt),2) as avg_loan_amount
from table_1
group by 1
order by 1;

select * from kpi7;

#8 Count of member_id by loan_amnt

drop table if exists kpi8;
create table kpi8
select loan_amnt as loan_amount, count(member_id) as count_of_members
from table_1
group by 1
order by 1;

select * from kpi8;