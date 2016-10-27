SELECT
	name, launched, 
	CASE
		WHEN 
			launched IS NULL
		THEN
			(
				SELECT
					name
				FROM
					Battles
				WHERE
					[date] =
					(
						SELECT
							MAX([date])
						FROM
							Battles
					)
			)
		ELSE
			CASE
				WHEN
					NOT EXISTS
					(
						SELECT
							MIN([date])
						FROM
							Battles
						WHERE
							YEAR([date]) >= launched
					)
				THEN
					NULL
				ELSE
					(
						SELECT
							name
						FROM
							Battles
						WHERE
							[date] =
							(
								SELECT
									MIN([date])
								FROM
									Battles
								WHERE
									YEAR([date]) >= launched
							)
					)
			END
	END
FROM
	Ships
