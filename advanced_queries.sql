-- Retrieve names of candidates who have applied for jobs with salary above $70,000 and have completed at least one training program
SELECT DISTINCT u.Name
FROM User u
WHERE EXISTS (
    SELECT 1
    FROM Candidate c
    JOIN Job j ON c.JobID = j.JobID
    WHERE c.UserID = u.UserID
    AND j.Salary > 70000
    AND EXISTS (
        SELECT 1
        FROM Participant p
        WHERE p.UserID = u.UserID
        AND p.CompleteDate IS NOT NULL
    )
);

-- List all users who have participated in successful collaborative projects that require "Technical" skills
SELECT DISTINCT u.Name
FROM User u
WHERE EXISTS (
    SELECT 1
    FROM Member m
    JOIN CollabProj cp ON m.ProjectID = cp.ProjectID
    WHERE m.UserID = u.UserID
    AND cp.SkillsNeededLearned LIKE '%Technical%'
    AND EXISTS (
        SELECT 1
        FROM Resource r
        WHERE r.CompanyID = cp.ProjectID
        AND r.Availability = 1
    )
);

-- Find the companies that have posted the most jobs with a salary greater than $50,000
SELECT c.Name, COUNT(j.JobID) AS JobCount
FROM Company c
JOIN Job j ON c.CompanyID = j.CompanyID
WHERE j.Salary > 50000
GROUP BY c.Name
ORDER BY JobCount DESC
LIMIT 1;

-- Find the most popular job title (the one with the highest number of applications)
SELECT 
    j.Title AS JobTitle,
    COUNT(ca.CandidateID) AS ApplicationCount
FROM 
    Job j
JOIN 
    Candidate ca ON j.JobID = ca.JobID
GROUP BY 
    j.Title
ORDER BY 
    ApplicationCount DESC
LIMIT 1;


-- Find users who contributed the most hours to collaborative projects
SELECT 
    u.Name AS UserName,
    SUM(m.HoursContributed) AS TotalHours
FROM 
    User u
JOIN 
    Member m ON u.UserID = m.UserID
GROUP BY 
    u.UserID, u.Name
ORDER BY 
    TotalHours DESC
