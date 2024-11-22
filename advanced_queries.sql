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

-- Retrieve all collaborative projects with more than 5 members and at least one resource contributed by a company
SELECT DISTINCT cp.Name
FROM CollabProj cp
WHERE cp.NumberOfMembers > 5
AND EXISTS (
    SELECT 1
    FROM Resource r
    WHERE r.CompanyID = cp.ProjectID
    AND r.Availability = 1
);

-- Find the users who have been members of collaborative projects involving endangered or critically endangered species
SELECT DISTINCT u.Name
FROM User u
WHERE EXISTS (
    SELECT 1
    FROM Member m
    JOIN CollabProj cp ON m.ProjectID = cp.ProjectID
    JOIN Observation o ON cp.ProjectID = o.ProjectID
    JOIN Species s ON o.SpeciesID = s.SpeciesID
    WHERE m.UserID = u.UserID
    AND s.IUCNStatus IN ('Endangered', 'Critically Endangered')
);
