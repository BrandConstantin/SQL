/*
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy:
FOUNDER > LEAD MANAGER > SENIOR MANAGER > MANAGER > EMPLOYEE

Given the table schemas below, write a query to print the company_code, founder name, total number of lead 
managers, total number of senior managers, total number of managers, and total number of employees. Order 
your output by ascending company_code.
*/

SELECT 
    C.COMPANY_CODE, C.FOUNDER, 
    COUNT(DISTINCT(L.LEAD_MANAGER_CODE)), 
    COUNT(DISTINCT(S.SENIOR_MANAGER_CODE)), 
    COUNT(DISTINCT(M.MANAGER_CODE)),
    COUNT(DISTINCT(E.EMPLOYEE_CODE)) 
FROM COMPANY C, LEAD_MANAGER L, SENIOR_MANAGER S, MANAGER M, EMPLOYEE E
WHERE C.COMPANY_CODE = L.COMPANY_CODE
AND L.LEAD_MANAGER_CODE = S.LEAD_MANAGER_CODE
AND S.SENIOR_MANAGER_CODE = M.SENIOR_MANAGER_CODE
AND M.MANAGER_CODE = E.MANAGER_CODE
GROUP BY C.COMPANY_CODE, C.FOUNDER ORDER BY C.COMPANY_CODE;