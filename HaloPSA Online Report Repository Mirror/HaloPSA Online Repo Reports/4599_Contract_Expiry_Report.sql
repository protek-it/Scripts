SELECT
    CONTRACTHEADER.CHid AS [Contract ID],
    AREA.aareadesc AS [Client],
    CONTRACTHEADER.CHNote AS [Note],
    CAST(CONTRACTHEADER.CHstartdate AS DATE) AS [Start Date],
    CASE
        WHEN CONTRACTHEADER.CHenddate > '2099-01-01' THEN NULL
        ELSE CAST(CONTRACTHEADER.CHenddate AS DATE)
    END AS [Expiry Date],
    CASE
        WHEN CONTRACTHEADER.CHenddate < GETDATE() THEN CAST('Yes' AS NVARCHAR(3))
        ELSE 'No'
    END AS [Expired?],
    CASE
        WHEN CONTRACTHEADER.chtype = 0 THEN 'Fixed'
        WHEN CONTRACTHEADER.chtype = 1 THEN 'Pre-Pay'
        ELSE CAST(CONTRACTHEADER.chtype AS NVARCHAR(MAX))
    END AS [Contract Type]
FROM
    CONTRACTHEADER
LEFT JOIN AREA
    ON CONTRACTHEADER.charea = AREA.aarea
WHERE
    CONTRACTHEADER.CHenddate <= @ENDDATE