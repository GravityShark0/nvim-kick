return {
    'nvim-orgmode/orgmode',
    ft = 'org',

    config = {
        org_agenda_files = '~/Notes/**/*',
        org_default_notes_file = '~/Notes/refile.org',
        org_todo_keywords = {
            'TODO',
            'NEXT',
            'HOLD',
            'WAIT',
            'INC',
            '|',
            'DONE',
            'CANCEL',
        },
        org_agenda_start_on_weekday = false,
        org_agenda_min_height = 32,
        org_agenda_skip_scheduled_if_done = true,
        org_agenda_skip_deadline_if_done = true,
        mappings = {
            global = {
                org_agenda = false,
                org_capture = false,
            },
        },
    },
}
