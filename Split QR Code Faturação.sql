ALTER PROCEDURE SP_SplitATQR @qr NVARCHAR (512), @code VARCHAR (2) AS
SET NOCOUNT ON;
-- Criar tabela temporária para registo das posições

IF object_id (N'tempdb..#Temp_SplitQRCODE') IS NOT NULL
    BEGIN
        DROP TABLE #Temp_SplitQRCODE
    END

-- Eliminar tabela se existir
-- Split QR
    SELECT charindex ('A:', @qr) AS A
        , charindex ('B:', @qr) AS B
        , charindex ('C:', @qr) AS C
        , charindex ('D:', @qr) AS D
        , charindex ('E:', @qr) AS E
        , charindex ('F:', @qr) AS F
        , charindex ('G:', @qr) AS G
        , charindex ('H:', @qr) AS H
        , charindex ('I1:', @qr) AS I1
        , charindex ('I2:', @qr) AS I2
        , charindex ('I3:', @qr) AS I3
        , charindex ('I4:', @qr) AS I4
        , charindex ('I5:', @qr) AS I5
        , charindex ('I6:', @qr) AS I6
        , charindex ('I7:', @qr) AS I7
        , charindex ('I8:', @qr) AS I8
        , charindex ('J1:', @qr) AS J1
        , charindex ('J2:', @qr) AS J2
        , charindex ('J3:', @qr) AS J3
        , charindex ('J4:', @qr) AS J4
        , charindex ('J5:', @qr) AS J5
        , charindex ('J6:', @qr) AS J6
        , charindex ('J7:', @qr) AS J7
        , charindex ('J8:', @qr) AS J8
        , charindex ('K1:', @qr) AS K1
        , charindex ('K2:', @qr) AS K2
        , charindex ('K3:', @qr) AS K3
        , charindex ('K4:', @qr) AS K4
        , charindex ('K5:', @qr) AS K5
        , charindex ('K6:', @qr) AS K6
        , charindex ('K7:', @qr) AS K7
        , charindex ('K8:', @qr) AS K8
        , charindex ('L:', @qr) AS L
        , charindex ('M:', @qr) AS M
        , charindex ('N:', @qr) AS N
        , charindex ('O:', @qr) AS O
        , charindex ('P:', @qr) AS P
        , charindex ('Q:', @qr) AS Q
        , charindex ('R:', @qr) AS R
        , charindex ('S:', @qr) AS S 
    INTO #Temp_SplitQRCODE 
        
DECLARE @response NVARCHAR (70);


/*
-- debug
    SELECT *
    FROM #Temp_SplitQRCODE
*/    

    
    SET @response = (CASE
-- NIF do emitente
                         WHEN @code = 'A' AND (SELECT A
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT a + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT b - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT a + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS NIF_E)
-- NIF do adquirente
                         WHEN @code = 'B' AND (SELECT B
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT b + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT c - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT b + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS NIF_A)
-- País do adquirente
                         WHEN @code = 'C' AND (SELECT C
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT c + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT d - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT c + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS Country)
-- Tipo de documento
                         WHEN @code = 'D' AND (SELECT D
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT d + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT e - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT d + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS Doc)
-- Estado do documento
                         WHEN @code = 'E' AND (SELECT E
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT e + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT f - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT e + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS Doc_Status)
-- Data do documento
                         WHEN @code = 'F' AND (SELECT F
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT f + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT g - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT f + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS Doc_Date)
-- Identificação única do documento
                         WHEN @code = 'G' AND (SELECT G
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT g + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT h - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT g + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS Doc_No)
-- ATCUD
                         WHEN @code = 'H' AND (SELECT H
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT h + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT i1 - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT h + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS ATCUD)
-- Espaço fiscal
                         WHEN @code = 'I1' AND (SELECT I1
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i1 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT i2 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i1 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS E_Fiscal)
-- Base tributável isenta de IVA
                         WHEN @code = 'I2' AND (SELECT I2
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i2 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT i3 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i2 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Ise_Base)
-- Base tributável de IVA à taxa reduzida
                         WHEN @code = 'I3' AND (SELECT I3
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i3 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT i4 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i3 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Red_Base)
-- Total de IVA à taxa reduzida
                         WHEN @code = 'I4' AND (SELECT I4
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i4 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT i5 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i4 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Red)
-- Base tributável de IVA à taxa intermédia
                         WHEN @code = 'I5' AND (SELECT I5
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i5 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT i6 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i5 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Int_Base)
-- Total de IVA à taxa intermédia
                         WHEN @code = 'I6' AND (SELECT I6
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i6 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT i7 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i6 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Int)
-- Base tributável de IVA à taxa normal
                         WHEN @code = 'I7' AND (SELECT I7
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i7 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT i8 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i7 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Nor_Base)
-- Total de IVA à taxa normal
                         WHEN @code = 'I8' AND (SELECT I8
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT i8 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j1 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT i8 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Nor)
-- Espaço fiscal
                         WHEN @code = 'J1' AND (SELECT J1
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j1 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j2 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j1 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS E_Fiscal)
-- Base tributável isenta
                         WHEN @code = 'J2' AND (SELECT J2
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j2 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j3 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j2 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Ise_Base)
-- Base tributável de IVA à taxa reduzida
                         WHEN @code = 'J3' AND (SELECT J3
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j3 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j4 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j3 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Red_Base)
-- Total de IVA à taxa reduzida
                         WHEN @code = 'J4' AND (SELECT J4
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j4 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j5 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j4 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Red)
-- Base tributável de IVA à taxa intermédia
                         WHEN @code = 'J5' AND (SELECT J5
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j5 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j6 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j5 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Int_Base)
-- Total de IVA à taxa intermédia
                         WHEN @code = 'J6' AND (SELECT J6
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j6 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j7 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j6 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Int)
-- Base tributável de IVA à taxa normal
                         WHEN @code = 'J7' AND (SELECT J7
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j7 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT j8 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j7 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Nor_Base)
-- Total de IVA à taxa normal
                         WHEN @code = 'J8' AND (SELECT J8
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT j8 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k1 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT j8 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Nor)
-- Espaço fiscal
                         WHEN @code = 'K1' AND (SELECT K1
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k1 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k2 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k1 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS E_Fiscal)
-- Base tributável isenta
                         WHEN @code = 'K2' AND (SELECT K2
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k2 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k3 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k2 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Ise_Base)
-- Base tributável de IVA à taxa reduzida
                         WHEN @code = 'K3' AND (SELECT K3
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k3 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k4 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k3 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Red_Base)
-- Total de IVA à taxa reduzida
                         WHEN @code = 'K4' AND (SELECT K4
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k4 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k5 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k4 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Red)
-- Base tributável de IVA à taxa intermédia
                         WHEN @code = 'K5' AND (SELECT K5
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k5 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k6 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k5 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Int_Base)
-- Total de IVA à taxa intermédia
                         WHEN @code = 'K6' AND (SELECT K6
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k6 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k7 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k6 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Int)
-- Base tributável de IVA à taxa normal
                         WHEN @code = 'K7' AND (SELECT K7
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k7 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT k8 - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k7 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Nor_Base)
-- Total de IVA à taxa normal
                         WHEN @code = 'K8' AND (SELECT K8
                                                FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT k8 + 3
                                                                                                          FROM #Temp_SplitQRCODE), ((SELECT l - 1
                                                                                                                                     FROM #Temp_SplitQRCODE) -(SELECT k8 + 3
                                                                                                                                                               FROM #Temp_SplitQRCODE))) AS VAT_Nor)
-- Não sujeito / não tributável em IVA
                         WHEN @code = 'L' AND (SELECT L
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT l + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT m - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT l + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS VAT_NS)
-- Imposto do Selo
                         WHEN @code = 'M' AND (SELECT M
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT m + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT n - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT m + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS ISelo)
-- Total de impostos
                         WHEN @code = 'N' AND (SELECT N
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT n + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT o - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT n + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS VAT_Total)
-- Total do documento com impostos
                         WHEN @code = 'O' AND (SELECT O
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT o + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT p - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT o + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS Total)
-- Retenções na fonte
                         WHEN @code = 'P' AND (SELECT P
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT p + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT q - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT p + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS IRS_IRC)
-- 4 carateres do Hash
                         WHEN @code = 'Q' AND (SELECT Q
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT q + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT r - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT q + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS Hash)
-- Nº do certificado
                         WHEN @code = 'R' AND (SELECT R
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT r + 2
                                                                                                         FROM #Temp_SplitQRCODE), ((SELECT s - 1
                                                                                                                                    FROM #Temp_SplitQRCODE) -(SELECT r + 2
                                                                                                                                                              FROM #Temp_SplitQRCODE))) AS CertNo)
-- Outras informações
                         WHEN @code = 'S' AND (SELECT S
                                               FROM #Temp_SplitQRCODE) > 0 THEN (SELECT substring (@qr, (SELECT s + 2
                                                                                                         FROM #Temp_SplitQRCODE), 65) AS Other_Info)
                         ELSE '*******'
                     END)
-- Show result
    SELECT @response
-- Cleanup
        DROP TABLE #Temp_SplitQRCODE GO