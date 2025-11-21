-- Common SQL queries I use for specimen tracking

-- 1. Daily collections per facility
SELECT facility, COUNT(*) as total_collected
FROM specimens
WHERE collection_date = CURRENT_DATE
GROUP BY facility
ORDER BY total_collected DESC;

-- 2. Average turnaround time by state
SELECT state, AVG(turnaround_days) as avg_days
FROM specimens s
JOIN facilities f ON s.facility_id = f.id
WHERE status = 'Received'
GROUP BY state
HAVING AVG(turnaround_days) > 7;

-- 3. Delayed specimens (more than 7 days)
SELECT specimen_id, facility, collection_date, status
FROM specimens
WHERE status != 'Received' AND collection_date < CURRENT_DATE - INTERVAL '7 days';
