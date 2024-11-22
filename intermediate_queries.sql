-- Get all job postings with their associated company names
SELECT j.Title, j.Location, j.Salary, c.Name AS CompanyName
FROM Job j
JOIN Company c ON j.CompanyID = c.CompanyID;

-- Find users who have completed a specific training program
SELECT u.Name, u.Skills, u.Certifications
FROM User u
JOIN Participant p ON u.UserID = p.UserID
WHERE p.ProgramID = 5 AND p.CompleteDate IS NOT NULL;

-- List all candidates who have applied for jobs in a specific location (e.g., 'San Jose, CA')
SELECT c.CandidateID, u.Name AS CandidateName, j.Title AS JobTitle
FROM Candidate c
JOIN User u ON c.UserID = u.UserID
JOIN Job j ON c.JobID = j.JobID
WHERE j.Location = 'San Jose, CA';

-- Get the total number of candidates who have applied for each job and order by the number of applications
SELECT j.JobID, j.Title, COUNT(c.CandidateID) AS NumberOfApplications
FROM Job j
LEFT JOIN Candidate c ON j.JobID = c.JobID
GROUP BY j.JobID, j.Title
ORDER BY NumberOfApplications DESC;

-- List users who are members of collaborative projects and the roles they play
SELECT u.Name, cp.Name AS ProjectName, m.Role
FROM User u
JOIN Member m ON u.UserID = m.UserID
JOIN CollabProj cp ON m.ProjectID = cp.ProjectID;
