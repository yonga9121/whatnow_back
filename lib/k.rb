module K

    SKILL_KINDS = {
        ability: 0,
        soft: 1
    }
    VIDEO_KINDS = {
        desc: 0,
        additional: 100
    }
    CANDIDATE_STATUSES = {
        on_review: 0,
        on_selection: 1,
        on_evaluation:2,
        success: 100,
        skiped_by_hunter: 200,
        skiped_by_user: 201,
        failed: 300
    }
    PRIORITIES = {
        low: 0,
        medium: 1,
        high: 2
    }
    OFFER_STATUSES = {
        active: 0,
        completed: 1,
        on_hold: 2,
        closed: 3
    }
end 