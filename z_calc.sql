WITH
inf AS (
    SELECT DISTINCT lemma
    FROM verben
    WHERE REGEXP_LIKE(tags, '(.*):INF:(.*)')
)
,
verben AS (
    SELECT verben.*
    FROM verben
    INNER JOIN inf USING (lemma)
)
,
stamm_all AS (
    SELECT form
           ,lemma
           ,length(form)                                 AS form_length
           ,min(length(form)) OVER(PARTITION BY lemma)   AS form_length_min
    FROM verben
    WHERE REGEXP_LIKE(tags, 'VER:SIN:IMP(.*)')
        AND length(form) > 0
    GROUP BY 1, 2
)
,
stamm AS (
    SELECT form, lemma
    FROM stamm_all
    WHERE form_length = form_length_min
)
,
praeteritum AS (
    SELECT form, lemma
    FROM verben
    WHERE REGEXP_LIKE(tags, 'VER:SIN(.*)1:PRT')
)

SELECT COUNT(1)                                             AS cnt_all
      ,SUM(CONCAT(stamm.form, 'te') != praeteritum.form)    AS cnt_irregular
FROM stamm
INNER JOIN praeteritum USING (lemma)
;
