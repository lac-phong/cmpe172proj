-- Query 1: List all users with their name and contact information
SELECT Name, ContactInfo
FROM User;

-- Query 2: Find all job postings with their title, location, and salary
SELECT Title, Location, Salary
FROM Job;

-- Query 3: Get the number of candidates that applied for each job
SELECT JobID, COUNT(*) AS NumberOfApplications
FROM Candidate
GROUP BY JobID;

-- Query 4: List all companies and the jobs they have posted
SELECT c.Name AS CompanyName, j.Title AS JobTitle
FROM Company c
JOIN Job j ON c.CompanyID = j.CompanyID;

-- Query 5: Find all candidates who applied for a specific job (e.g., JobID = 101)
SELECT u.Name AS CandidateName, c.DateApplied, c.Status
FROM Candidate c
JOIN User u ON c.UserID = u.UserID
WHERE c.JobID = 101;
