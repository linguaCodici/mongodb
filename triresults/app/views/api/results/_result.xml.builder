xml.result do
    xml.place result.overall_place
    xml.time format_hours result.secs
    xml.last_name result.last_name
    xml.first_name result.first_name
    xml.bib result.bib
    xml.city result.city
    xml.state result.state
    xml.gender result.racer_gender
    xml.gender_place result.gender_place
    xml.group result.group_name
    xml.group_place result.group_place

    xml.swim format_hours result.swim_secs
    xml.pace_100 format_minutes result.swim_pace_100
    xml.t1 format_minutes result.t1_secs
    xml.bike format_hours result.bike_secs
    xml.mph format_mph result.bike_mph
    xml.t2 format_minutes result.t2_secs
    xml.run format_hours result.run_secs
    xml.mmile format_minutes result.run_mmile

    xml.result_url api_race_result_url(result.race.id, result)
    if result.racer.id
      xml.racer_url api_racer_url(result.racer.id)
    end
end
