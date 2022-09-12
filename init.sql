DROP DATABASE IF EXISTS BoomiDevOpsCenter ;
CREATE DATABASE BoomiDevOpsCenter CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
Use BoomiDevOpsCenter;

CREATE TABLE CICDActualDocument (
  testId int NOT NULL,
  tpId int NOT NULL,
  docIndex int NOT NULL,
  visitIndex int NOT NULL,
  actual longtext,
   lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, 
  report text,
  executionId varchar(64) NOT NULL,
  status varchar(32) DEFAULT NULL,
  expected longtext,
  docPropStatus varchar(32) DEFAULT NULL
  ,PRIMARY KEY (tpId,executionId,docIndex,visitIndex)
) Engine= InnoDB;

CREATE TABLE CICDActualDocumentProperty (
  testId int NOT NULL,
  tpId int NOT NULL,
  executionId varchar(64) NOT NULL,
  docIndex int NOT NULL,
  visitIndex int NOT NULL,
  propName varchar(128) NOT NULL,
  expectedValue mediumtext,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualValue mediumtext,
  status varchar(32) DEFAULT NULL
  ,PRIMARY KEY (tpId,executionId,docIndex,visitIndex,propName)
) Engine= InnoDB;

CREATE TABLE CICDActualProcessProperty (
  testId int NOT NULL,
  tpId int NOT NULL,
  executionId varchar(64) NOT NULL,
  visitIndex int NOT NULL,
  propName varchar(128) NOT NULL,
  expectedValue mediumtext,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualValue mediumtext,
  status varchar(32) DEFAULT NULL
  ,PRIMARY KEY (tpId,executionId,visitIndex,propName)
) Engine= InnoDB;

CREATE TABLE CICDExpectedDocument (
  testId int NOT NULL,
  tpId int NOT NULL,
  visitIndex int NOT NULL,
  docIndex int NOT NULL,
  expected longtext,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tpId,testId,visitIndex,docIndex)
) Engine=InnoDB;

CREATE TABLE CICDExpectedDocumentProperty (
  testId int NOT NULL,
  docIndex int NOT NULL,
  propName varchar(128) NOT NULL,
  propValue mediumtext,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  tpId int NOT NULL,
  visitIndex int NOT NULL,
  PRIMARY KEY (tpId,testId,propName,visitIndex,docIndex)
) Engine=InnoDB;

CREATE TABLE CICDExpectedProcessProperty (
  testId int NOT NULL,
  propName varchar(128) NOT NULL,
  propValue mediumtext,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  tpId int NOT NULL,
  visitIndex int NOT NULL,
  PRIMARY KEY (tpId,testId,propName,visitIndex)
) Engine=InnoDB;

CREATE TABLE CICDInjectionPoint (
  ipId int NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  description varchar(255) DEFAULT NULL,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  accountId varchar(64) DEFAULT NULL,
  authenticationType varchar(16),
  username varchar(255),
  token varchar(255),
  host varchar(255),
  urlPath varchar(255),
  httpMethod varchar(16),
  apiType varchar(8),
  isBase64 tinyint(1) DEFAULT 0,
  PRIMARY KEY (ipId)
) Engine=InnoDB;

CREATE TABLE CICDInjectionPointProcessId (
  ipId int NOT NULL,
  processId varchar(64) NOT NULL,
  PRIMARY KEY (ipId,processId)
) Engine=InnoDB;

CREATE TABLE CICDMockDocument (
  testId int NOT NULL,
  ipId int NOT NULL,
  visitIndex int NOT NULL,
  docIndex int NOT NULL,
  mock longtext,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ipId,testId,visitIndex,docIndex)
) Engine=InnoDB;

CREATE TABLE CICDMockDocumentProperty (
  testId int NOT NULL,
  docIndex int NOT NULL,
  propName varchar(255) NOT NULL,
  propValue mediumtext,
  ipId int NOT NULL,
  visitIndex int NOT NULL,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ipId,testId,propName,visitIndex,docIndex)
) Engine=InnoDB;

CREATE TABLE CICDMockProcessProperty (
  testId int NOT NULL,
  ipId int NOT NULL,
  visitIndex int NOT NULL,
  propName varchar(255) NOT NULL,
  propValue mediumtext,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ipId,testId,propName,visitIndex)
) Engine=InnoDB;

CREATE TABLE CICDProcessTest (
  testId int NOT NULL AUTO_INCREMENT,
  processId varchar(64) NOT NULL,
  isCurrent tinyint(1) DEFAULT 0,
  name varchar(255) NOT NULL,
  description varchar(255) DEFAULT NULL,
  lastModifiedBy varchar(64),
  disabled tinyint(1) DEFAULT 0,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  accountId varchar(64) DEFAULT NULL,
  executionDurationLimit int,
  expectedState varchar(255),
  expectedMessage varchar(255),
  PRIMARY KEY (testId)
) Engine=InnoDB;

CREATE TABLE CICDTestExecution (
  testId int NOT NULL,
  executionId varchar(64) NOT NULL,
  status varchar(32) DEFAULT NULL,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  groupexecutionId varchar(64) DEFAULT NULL,
  state varchar(32) DEFAULT NULL,
  message text,
  executionDuration int,
  executionDurationLimit int(11) default 0,
  executionStart timestamp,
  executionEnd timestamp,
  expectedState varchar(255),
  expectedMessage varchar(510),
  PRIMARY KEY (executionId)
) Engine=InnoDB;

CREATE TABLE CICDTestPoint (
  tpId int NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  description varchar(255) DEFAULT NULL,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  docType varchar(32) DEFAULT NULL,
  ignoreElementOrder tinyint(1) DEFAULT 0,
  ignoreExtraElements tinyint(1) DEFAULT 0,
  ffDelimiter varchar(1) DEFAULT NULL,
  setBreakPoint tinyint(1) DEFAULT 0,
  stopFlow tinyint(1) DEFAULT 0,
  segmentTerminator varchar(1) DEFAULT NULL,
  subElementDelimiter varchar(1) DEFAULT NULL,
  EDISchema mediumtext,
  accountId varchar(64) DEFAULT NULL,
  PRIMARY KEY (tpId)
) Engine=InnoDB;

CREATE TABLE CICDTestPointFieldOption (
  id varchar(255) NOT NULL,
  tpId int NOT NULL,
  dataType varchar(25) NULL,
  minimumLength int DEFAULT 0,
  maximumLength int DEFAULT 0,
  minimumValue varchar(255),
  maximumValue varchar(255),
  formatMask varchar(255) NULL,
  description varchar(255) DEFAULT NULL,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tpId,id)
) Engine=InnoDB;

CREATE TABLE CICDTestSuiteExecution (
  id varchar(64),
  startTime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  totalNumberTests int DEFAULT 0,
  totalNumberEnabledTests int DEFAULT 0,
  PRIMARY KEY (id)
) Engine=InnoDB;

CREATE TABLE CICDTestpointExecution (
  testId int NOT NULL,
  executionId varchar(64) NOT NULL,
  tpId int NOT NULL,
  status varchar(32) DEFAULT NULL,
  lastModified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  processPropStatus varchar(32) DEFAULT NULL,
  expectedNumberDocuments int DEFAULT NULL,
  actualNumberDocuments int DEFAULT NULL,
  PRIMARY KEY (executionId,tpId)
) Engine=InnoDB;

CREATE TABLE CICDTestPointProcessId (
  tpId int NOT NULL,
  processId varchar(64) NOT NULL,
  PRIMARY KEY (tpId,processId)
) Engine=InnoDB;

ALTER TABLE CICDExpectedDocument 
 ADD FOREIGN KEY (tpId) REFERENCES CICDTestPoint(tpId) ON DELETE CASCADE,
 ADD FOREIGN KEY (testId) REFERENCES CICDProcessTest(testId) ON DELETE CASCADE
;

ALTER TABLE CICDExpectedDocumentProperty 
 ADD FOREIGN KEY (tpId,testId,visitIndex,docIndex) REFERENCES CICDExpectedDocument(tpId,testId,visitIndex,docIndex) ON DELETE CASCADE
;

ALTER TABLE CICDExpectedProcessProperty 
 ADD FOREIGN KEY (tpId) REFERENCES CICDTestPoint(tpId) ON DELETE CASCADE,
 ADD FOREIGN KEY (testId) REFERENCES CICDProcessTest(testId) ON DELETE CASCADE
;

ALTER TABLE CICDMockDocument 
 ADD FOREIGN KEY (ipId) REFERENCES CICDInjectionPoint(ipId) ON DELETE CASCADE,
 ADD FOREIGN KEY (testId) REFERENCES CICDProcessTest(testId) ON DELETE CASCADE
;

ALTER TABLE CICDMockDocumentProperty 
 ADD FOREIGN KEY (ipId,testId,visitIndex,docIndex) REFERENCES CICDMockDocument(ipId,testId,visitIndex,docIndex) ON DELETE CASCADE
;

ALTER TABLE CICDMockProcessProperty 
 ADD FOREIGN KEY (ipId) REFERENCES CICDInjectionPoint(ipId) ON DELETE CASCADE,
 ADD FOREIGN KEY (testId) REFERENCES CICDProcessTest(testId) ON DELETE CASCADE
;

ALTER TABLE CICDTestPointFieldOption 
 ADD FOREIGN KEY (tpId) REFERENCES CICDTestPoint(tpId) ON DELETE CASCADE
;

ALTER TABLE CICDTestPointProcessId 
 ADD FOREIGN KEY (tpId) REFERENCES CICDTestPoint(tpId) ON DELETE CASCADE
;

ALTER TABLE CICDInjectionPointProcessId 
 ADD FOREIGN KEY (ipId) REFERENCES CICDInjectionPoint(ipId) ON DELETE CASCADE
;

DELIMITER //
CREATE PROCEDURE copy_process_test(IN testIdtoCopy int)
BEGIN
   DECLARE newTestId int;
   insert into CICDProcessTest (name, description, processId) select CONCAT(name, ' (copy)') as name, description, processId from CICDProcessTest t where t.testId = testIdtoCopy;
   SET newTestId = (SELECT LAST_INSERT_ID());
   insert into CICDMockDocument (testId, ipId, visitIndex, docIndex, mock) select newTestId, ipId, visitIndex, docIndex, mock from CICDMockDocument d where d.testId = testIdtoCopy;
   insert into CICDMockDocumentProperty (testId, ipId, visitIndex, docIndex, propName, propValue) select newTestId, ipId, visitIndex, docIndex, propName, propValue from CICDMockDocumentProperty dp where dp.testId = testIdtoCopy;
   insert into CICDMockProcessProperty (testId, ipId, visitIndex, propName, propValue) select newTestId, ipId, visitIndex, propName, propValue from CICDMockProcessProperty d where d.testId = testIdtoCopy;
   insert into CICDExpectedDocument (testId, tpId, visitIndex, docIndex, expected) select newTestId, tpId, visitIndex, docIndex, expected from CICDExpectedDocument d where d.testId = testIdtoCopy;
   insert into CICDExpectedDocumentProperty (testId, tpId, visitIndex, docIndex, propName, propValue) select newTestId, tpId, visitIndex, docIndex, propName, propValue from CICDExpectedDocumentProperty dp where dp.testId = testIdtoCopy;
   insert into CICDExpectedProcessProperty (testId, tpId, visitIndex, propName, propValue) select newTestId, tpId, visitIndex, propName, propValue from CICDExpectedProcessProperty d where d.testId = testIdtoCopy;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE upsert_testpointfieldoption(IN dataType varchar(25), IN description varchar(255), IN formatMask varchar(255), IN id varchar(255), IN lastModified timestamp, IN maximumLength int, IN maximumValue varchar(255), IN minimumLength int, IN minimumValue varchar(255), IN tpId int)
BEGIN

INSERT INTO CICDTestPointFieldOption (dataType,description,formatMask,id,lastModified,maximumLength,maximumValue,minimumLength,minimumValue,tpId)
VALUES (dataType,description,formatMask,id,lastModified,maximumLength,maximumValue,minimumLength,minimumValue,tpId)
ON DUPLICATE KEY UPDATE
 dataType = dataType,description = description,formatMask = formatMask,id = id,lastModified = lastModified,maximumLength = maximumLength,maximumValue = maximumValue,minimumLength = minimumLength,minimumValue = minimumValue,tpId = tpId;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE upsert_expected_document(IN docIndex int, IN expected longtext, IN testId int, IN tpId int, IN visitIndex int, IN lastModified timestamp)
BEGIN

INSERT INTO CICDExpectedDocument (docIndex, expected, testId, tpId, visitIndex, lastModified)
VALUES (docIndex, expected, testId, tpId, visitIndex, lastModified)
ON DUPLICATE KEY UPDATE 
   docIndex= docIndex,
   expected= expected, 
  testId = testId,
   tpId= tpId, 
   visitIndex=visitIndex,
lastModified=lastModified;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE upsert_expected_document_properties(IN docIndex int, IN propName varchar(128), IN propValue mediumtext, IN testId int, IN tpId int, IN visitIndex int, IN lastModified timestamp)
BEGIN

INSERT INTO CICDExpectedDocumentProperty (docIndex, propName, propValue, testId, tpId, visitIndex,lastModified)
VALUES (docIndex, propName, propValue, testId, tpId, visitIndex,lastModified)
ON DUPLICATE KEY UPDATE
   docIndex= docIndex, 
   propName= propName, 
   propValue= propValue,
   testId = testId,
   tpId= tpId, 
   visitIndex = visitIndex,
   lastModified=lastModified;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE upsert_test_execution_state(IN testId int, IN executionId varchar(64), IN groupExecutionId varchar(64), IN state varchar(32), IN message text, IN lastModified timestamp, IN executionDuration int, IN executionDurationLimit int, IN expectedState varchar(255), IN expectedMessage varchar(510))
BEGIN

INSERT INTO CICDTestExecution (testId, executionId, groupExecutionId, state, message, lastModified, executionDuration, executionDurationLimit, expectedState, expectedMessage)
VALUES (testId, executionId, groupExecutionId, state, message,lastModified,executionDuration, executionDurationLimit, expectedState, expectedMessage)
ON DUPLICATE KEY UPDATE 
   testId= testId, 
   executionId= executionId, 
   groupExecutionId= groupExecutionId,
   state= state, 
   message= message,
   lastModified=lastModified,
   executionDuration=executionDuration,
   executionDurationLimit=executionDurationLimit,
   expectedState=expectedState,
   expectedMessage=expectedMessage;

END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE upsert_expected_process_properties(IN propValue mediumtext, IN propName varchar(128), IN testId int, IN tpId int, IN visitIndex int, IN lastModified timestamp)
BEGIN

INSERT INTO CICDExpectedProcessProperty (propValue, propName, testId, tpId, visitIndex, lastModified)
VALUES (propValue, propName, testId, tpId, visitIndex, lastModified)
ON DUPLICATE KEY UPDATE 
   propValue= propValue,
   propName= propName, 
   testId = testId,
   tpId= tpId, 
   visitIndex = visitIndex,
   lastModified = lastModified;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE upsert_mock_document(IN mock longtext, IN ipId int, IN testId int, IN docIndex int, IN visitIndex int, IN lastModified timestamp)
BEGIN

INSERT INTO CICDMockDocument (mock, ipId, testId, docIndex,visitIndex,lastModified)
VALUES (mock, ipId, testId, docIndex,visitIndex,lastModified)
 ON DUPLICATE KEY UPDATE 
   mock = mock, 
   ipId= ipId,
   testId = testId,
   docIndex= docIndex,
   visitIndex=visitIndex,
   lastModified=lastModified;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE upsert_mock_document_properties(IN docIndex int, IN propName varchar(128), IN propValue mediumtext, IN testId int, IN ipId int, IN visitIndex int, IN lastModified timestamp)
BEGIN

INSERT INTO CICDMockDocumentProperty (docIndex, propName, propValue, testId, ipId, visitIndex, lastModified)
VALUES (docIndex, propName, propValue, testId, ipId, visitIndex, lastModified)
 ON DUPLICATE KEY UPDATE
   docIndex= docIndex, 
   propName= propName, 
   propValue= propValue,
   testId = testId,
   ipId= ipId, 
   visitIndex=visitIndex,
   lastModified=lastModified;

END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE upsert_mock_process_properties(IN propName varchar(128), IN propValue mediumtext, IN testId int, IN ipId int, IN visitIndex int, IN lastModified timestamp)
BEGIN


INSERT INTO CICDMockProcessProperty (propName, propValue, testId, ipId, visitIndex, lastModified)
VALUES (propName, propValue, testId, ipId, visitIndex, lastModified)
ON DUPLICATE KEY UPDATE 
   propName= propName, 
   propValue= propValue,
   testId = testId,
   ipId= ipId, 
   visitIndex = visitIndex,
   lastModified = lastModified;

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_injection_point(IN name varchar(255), IN description varchar(255), IN lastModified timestamp, IN accountId varchar(64), IN authenticationType varchar(16), IN username varchar(255), IN token varchar(255), IN host varchar(255), IN urlPath varchar(255), IN httpMethod varchar(16), IN isBase64 tinyint(1), IN processId varchar(64))
BEGIN

INSERT INTO BoomiDevOpsCenter.CICDInjectionPoint 
	(name, description, lastModified, accountId, authenticationType, 
	username, token, host, urlPath, httpMethod, isBase64) 
VALUES (name, description, lastModified, accountId, authenticationType, 
	username, token, host, urlPath, httpMethod, isBase64);  

INSERT INTO CICDInjectionPointProcessId (ipId, processId)
VALUES (LAST_INSERT_ID(), processId);

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE insert_test_point(IN name varchar(255), IN description varchar(255), IN lastModified timestamp, IN docType varchar(32), IN ignoreElementOrder tinyint(1), IN ignoreExtraElements tinyint(1), IN ffDelimiter varchar(1), IN setBreakPoint tinyint(1), IN segmentTerminator varchar(1), IN subElementDelimiter varchar(1), IN EDISchema mediumtext, IN accountId varchar(64), IN processId varchar(64), IN stopFlow tinyint(1))
BEGIN
  
INSERT INTO BoomiDevOpsCenter.CICDTestPoint 
	(name, description, lastModified, docType, ignoreElementOrder, ignoreExtraElements, 
	ffDelimiter, setBreakPoint, segmentTerminator, EDISchema, subElementDelimiter, accountId, stopFlow) 
VALUES (name, description, lastModified, docType, ignoreElementOrder, ignoreExtraElements, 
	ffDelimiter, setBreakPoint, segmentTerminator, EDISchema, subElementDelimiter, accountId, stopFlow);
 
INSERT INTO CICDTestPointProcessId (tpId, processId)
VALUES (LAST_INSERT_ID(), processId);

END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE query_test_execution_history_process_id(IN processId varchar(128), in suiteExecutionId varchar(128), in executionId varchar(128))
BEGIN
		SELECT t.name, t.description, t.processId, te.executionDuration/1000,
	    (SELECT min(executionDuration)/1000 FROM CICDTestExecution te2 where te2.testId = te.testId) as executionDurationMin,
	    (SELECT max(executionDuration)/1000 FROM CICDTestExecution te2 where te2.testId = te.testId) as executionDurationMax,
	    (SELECT avg(executionDuration)/1000 FROM CICDTestExecution te2 where te2.testId = te.testId) as executionDurationAvg,
	    (SELECT COUNT(*) FROM CICDTestPoint tp join CICDTestPointProcessId tpp on tpp.tpid = tp.tpid where tpp.processId=t.processId) as count_tp, 
	    (SELECT COUNT(distinct tpId) FROM CICDTestpointExecution tpe where executionId=te.executionId AND actualNumberDocuments<>0) as count_tpe, 
	    (100*(SELECT COUNT(distinct tpId) FROM CICDTestpointExecution tpe where executionId=te.executionId AND actualNumberDocuments<>0)
			/(SELECT COUNT(*) FROM CICDTestPoint tp5 join CICDTestPointProcessId tpp5 on tp5.tpId = tpp5.tpId where tpp5.processId=t.processId)) as test_coverage,
	    t.testId, 
	    te.lastModified, 
	    te.executionId, 
		(CASE 
		   WHEN te.state = 'INPROCESS' THEN 'INPROCESS'
		   WHEN(SELECT sum(actualNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId)
			  <>(SELECT sum(expectedNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId) THEN 'ERROR'
		   WHEN(length(te.expectedState)>0 AND te.expectedState<>te.state) THEN 'ERROR'
		   WHEN(length(te.expectedMessage)>0 AND te.expectedMessage<>te.message) THEN 'ERROR'
		   ELSE te.status 
		 END) as status,		
		(CASE WHEN (select count(*) from CICDTestSuiteExecution tse where te.groupExecutionId = tse.id) = 0 THEN 'Single Test Execution' else te.groupExecutionId END), 
	    te.message, 
		te.state,
	(SELECT sum(actualNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId) as actualNumberDocuments,
	(SELECT sum(expectedNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId) as expectedNumberDocuments,
	(CASE
	  WHEN te.executionDurationLimit = 0 or te.executionDurationLimit IS NULL OR te.executionDuration IS NULL THEN 'N/A'
	  WHEN te.executionDuration/1000 > te.executionDurationLimit THEN 'ERROR'
	  ELSE 'OK'
	END) as performanceStatus,
	 te.executionDurationLimit,
	 te.expectedState,
	 te.expectedMessage
	FROM CICDTestExecution AS te
	JOIN CICDProcessTest t on te.testId = t.testId
	WHERE t.processId = processId AND (length(suiteExecutionId) = 0  OR te.groupExecutionId=suiteExecutionId)  AND (length(executionId) = 0  OR te.executionId=executionId)
	ORDER BY te.lastModified desc limit 40;
END //
DELIMITER ;

DELIMITER //
	CREATE PROCEDURE get_test_execution_history(in processId varchar(32), in suiteExecutionId varchar(32))
	begin
		SELECT t.name, t.description, t.processId, te.executionDuration/1000,
		    (SELECT min(executionDuration)/1000 FROM CICDTestExecution te2 where te2.testId = te.testId) as executionDurationMin,
		    (SELECT max(executionDuration)/1000 FROM CICDTestExecution te2 where te2.testId = te.testId) as executionDurationMax,
		    (SELECT avg(executionDuration)/1000 FROM CICDTestExecution te2 where te2.testId = te.testId) as executionDurationAvg,
		    (SELECT COUNT(*) FROM CICDTestPoint tp join CICDTestPointProcessId tpp on tpp.tpid = tp.tpid where tpp.processId=t.processId) as count_tp,
		    (SELECT COUNT(distinct tpId) FROM CICDTestpointExecution tpe where executionId=te.executionId AND actualNumberDocuments<>0) as count_tpe,
		    (100*(SELECT COUNT(distinct tpId) FROM CICDTestpointExecution tpe where executionId=te.executionId AND actualNumberDocuments<>0)
				/(SELECT COUNT(*) FROM CICDTestPoint tp5 join CICDTestPointProcessId tpp5 on tp5.tpId = tpp5.tpId where tpp5.processId=t.processId)) as test_coverage,
		    t.testId,
		    te.lastModified,
		    te.executionId,

			(CASE
			   WHEN te.state = "INPROCESS" THEN "INPROCESS"
			   WHEN(SELECT sum(actualNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId)
				  <>(SELECT sum(expectedNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId) THEN 'ERROR'
			   WHEN(length(te.expectedState)>0 AND te.expectedState<>te.state) THEN 'ERROR'
			   WHEN(length(te.expectedMessage)>0 AND te.expectedMessage<>te.message) THEN 'ERROR'
			   ELSE te.status
			 END) as status,

			(CASE WHEN (select count(*) from CICDTestSuiteExecution tse where te.groupExecutionId = tse.id) = 0 THEN 'Single Test Execution' else te.groupExecutionId END),
		    te.message,
			te.state,
		(SELECT sum(actualNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId) as actualNumberDocuments,
		(SELECT sum(expectedNumberDocuments) FROM CICDTestpointExecution where te.executionId=executionId) as expectedNumberDocuments,
		(CASE
		  WHEN te.executionDurationLimit = 0 or te.executionDurationLimit IS NULL OR te.executionDuration IS NULL THEN "N/A"
		  WHEN te.executionDuration/1000 > te.executionDurationLimit THEN "ERROR"
		  ELSE "OK"
		END) as performanceStatus,
		 te.executionDurationLimit,
		 te.expectedState,
		 te.expectedMessage

		FROM CICDTestExecution AS te
		JOIN CICDProcessTest t on te.testId = t.testId
		WHERE t.processId = processId AND (length(suiteExecutionId) = 0  OR te.groupExecutionId=suiteExecutionId)
		ORDER BY te.lastModified desc limit 40;
END //
DELIMITER ;


DELIMITER //
	CREATE PROCEDURE get_test_suite_execution_status(in processId varchar(32), in suiteExecutionId varchar(32))
	begin
		select tse.totalNumberTests as numTests,
			SUM(CASE WHEN te.state <> 'STARTED' AND te.state <> 'INPROCESS' AND te.state <> 'UNKNOWN' THEN 1 ELSE 0 END) as numExecutions,
			SUM(CASE WHEN te.status = 'OK' AND te.state = 'COMPLETE' THEN 1 ELSE 0 END) as numOk,
			SUM(CASE WHEN te.status = 'ERROR' AND te.state = 'COMPLETE' THEN 1 ELSE 0 END) as numError,

		    SUM(CASE WHEN te.executionDurationLimit = 0 or te.executionDurationLimit IS NULL OR te.executionDuration IS NULL THEN 0
		             WHEN te.executionDuration/1000 > te.executionDurationLimit THEN 1
		             ELSE 0 END) as numPerformanceError,

		    SUM(CASE WHEN length(te.expectedState)=0 OR te.expectedState=te.state THEN 0
		             ELSE 1 END) as numStateError,

		    SUM(CASE WHEN length(te.expectedMessage)=0 OR te.expectedMessage=te.message THEN 0
		             ELSE 1 END) as numMessageError,

			(select Sum(expectedNumberDocuments)
				from CICDTestpointExecution tpe
				join CICDTestExecution tte on tpe.executionId = tte.executionId
				where tte.groupExecutionId = te.groupExecutionId
			) as numExpectedDocs,
			(select count(*)
				from CICDActualDocument ad
				join CICDTestExecution tte on ad.executionId = tte.executionId
				where tte.groupExecutionId = te.groupExecutionId
			) as numActualDocs,
			t.processId,
			te.groupExecutionId,
			tse.totalNumberEnabledTests as numEnabledTests,
			tse.startTime,
			(select 100*count(distinct tpe3.tpId)/
				(
				select count(*) from CICDTestPointProcessId tp2
					where tp2.processId=t.processId
				)
				from CICDTestpointExecution tpe3
				join CICDTestExecution te3 on te3.executionId = tpe3.executionId
				where te3.groupExecutionId = te.groupExecutionId
			) as coverage,
			(select sum(executionDuration)/1000 FROM CICDTestExecution te2 where te.groupExecutionId= te2.groupExecutionId) as executionDuration
		from CICDTestExecution te
		join CICDTestSuiteExecution tse on tse.id=te.groupExecutionId
		join CICDProcessTest t on te.testId = t.testId
		where t.processId = processId
		and not te.groupExecutionId is null and (length(suiteExecutionId) = 0 or te.groupExecutionId = suiteExecutionId)
		group by te.groupExecutionId, tse.totalNumberTests, t.processId, te.groupExecutionId, numEnabledTests, tse.startTime
		order by tse.startTime desc;
END //
DELIMITER ;

GRANT all ON BoomiDevOpsCenter.* TO 'boomi_devops'@'%';
