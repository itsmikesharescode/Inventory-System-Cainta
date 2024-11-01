create or replace function admin_dashboard_graph_counts() returns json as $$
declare
  result json;
begin
  with date_series as (
    -- Generate all dates for last 30 days
    select generate_series(
      current_date - interval '29 days',
      current_date,
      interval '1 day'
    )::date as day
  ),
  daily_status_counts as (
    select 
      date_trunc('day', created_at)::date as day,
      status,
      count(*) as count
    from reservations_tb
    where 
      created_at >= current_date - interval '29 days'
      and status in ('Pending', 'Accepted', 'Canceled')
    group by date_trunc('day', created_at)::date, status
  ),
  daily_total_counts as (
    select 
      date_trunc('day', created_at)::date as day,
      count(*) as count
    from reservations_tb
    where created_at >= current_date - interval '29 days'
    group by date_trunc('day', created_at)::date
  ),
  formatted_status_counts as (
    select 
      ds.day,
      to_char(ds.day, 'YYYY-MM-DD') as formatted_date,
      coalesce(sum(case when dsc.status = 'Pending' then dsc.count else 0 end), 0) as pending,
      coalesce(sum(case when dsc.status = 'Accepted' then dsc.count else 0 end), 0) as accepted,
      coalesce(sum(case when dsc.status = 'Canceled' then dsc.count else 0 end), 0) as canceled
    from date_series ds
    left join daily_status_counts dsc on ds.day = dsc.day
    group by ds.day
  ),
  formatted_total_counts as (
    select 
      ds.day,
      to_char(ds.day, 'YYYY-MM-DD') as formatted_date,
      coalesce(dtc.count, 0) as count
    from date_series ds
    left join daily_total_counts dtc on ds.day = dtc.day
  )
  select json_build_object(
    'pending', (
      select json_agg(
        json_build_object(
          'day', formatted_date,
          'count', pending
        )
        order by day
      )
      from formatted_status_counts
    ),
    'accepted', (
      select json_agg(
        json_build_object(
          'day', formatted_date,
          'count', accepted
        )
        order by day
      )
      from formatted_status_counts
    ),
    'canceled', (
      select json_agg(
        json_build_object(
          'day', formatted_date,
          'count', canceled
        )
        order by day
      )
      from formatted_status_counts
    ),
    'reservations', (
      select json_agg(
        json_build_object(
          'day', formatted_date,
          'count', count
        )
        order by day
      )
      from formatted_total_counts
    )
  ) into result;

  return result;
end;
$$ language plpgsql;