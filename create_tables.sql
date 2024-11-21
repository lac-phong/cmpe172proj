-- Table: User
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Name VARCHAR(100),
    ContactInfo VARCHAR(255),
    Resume TEXT,
    Skills TEXT,
    Experience TEXT,
    Certifications TEXT
);

-- Table: Resource
CREATE TABLE Resource (
    ResourceID INT PRIMARY KEY,
    Type VARCHAR(100),
    Description TEXT,
    Availability BOOLEAN,
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

-- Table: Company
CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Industry VARCHAR(100),
    FundingStage VARCHAR(100),
    NumberOfEmployees INT
);

-- Table: Job
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    Title VARCHAR(100),
    Description TEXT,
    Location VARCHAR(100),
    Salary DECIMAL(10, 2),
    Requirements TEXT,
    CompanyID INT,
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);

-- Table: Candidate
CREATE TABLE Candidate (
    CandidateID INT PRIMARY KEY,
    UserID INT,
    JobID INT,
    DateApplied DATE,
    InterviewDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Table: Member
CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    UserID INT,
    Role VARCHAR(50),
    JoinDate DATE,
    Status VARCHAR(50),
    ProjectID INT,
    HoursContributed DECIMAL(5, 2),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (ProjectID) REFERENCES CollabProj(ProjectID)
);

-- Table: CollabProj
CREATE TABLE CollabProj (
    ProjectID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    SkillsNeededLearned TEXT,
    NumberOfMembers INT
);

-- Table: Participant
CREATE TABLE Participant (
    ParticipantID INT PRIMARY KEY,
    UserID INT,
    ProgramID INT,
    EnrollDate DATE,
    CompleteDate DATE,
    CertificationStatus BOOLEAN,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (ProgramID) REFERENCES TrainingProgram(ProgramID)
);

-- Table: TrainingProgram
CREATE TABLE TrainingProgram (
    ProgramID INT PRIMARY KEY,
    Title VARCHAR(100),
    Description TEXT,
    ProgramType VARCHAR(50),
    Duration INT,
    Certification BOOLEAN
);

-- Relationship Table: USES	
CREATE TABLE Uses (
    UserID INT,
    ResourceID INT,
    PRIMARY KEY (UserID, ResourceID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (ResourceID) REFERENCES Resource(ResourceID)
);

-- Relationship Table: OFFERS
CREATE TABLE Offers (
    CompanyID INT,
    JobID INT,
    PRIMARY KEY (CompanyID, JobID),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Relationship Table: APPLIES
CREATE TABLE Applies (
    CandidateID INT,
    JobID INT,
    PRIMARY KEY (CandidateID, JobID),
    FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

-- Relationship Table: CONTRIBUTES
CREATE TABLE Contributes (
    MemberID INT,
    ProjectID INT,
    PRIMARY KEY (MemberID, ProjectID),
    FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
    FOREIGN KEY (ProjectID) REFERENCES CollabProj(ProjectID)
);

-- Relationship Table: PARTICIPATES
CREATE TABLE Participates (
    ParticipantID INT,
    ProgramID INT,
    PRIMARY KEY (ParticipantID, ProgramID),
    FOREIGN KEY (ParticipantID) REFERENCES Participant(ParticipantID),
    FOREIGN KEY (ProgramID) REFERENCES TrainingProgram(ProgramID)
);
