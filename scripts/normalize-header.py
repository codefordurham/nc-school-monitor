'''Filter to clean and normalize csv headers.'''
import csv
import sys

HEADER_MAP = {
    'regionname': 'region_name',
    'leacode': 'lea_code',
    'schoolcode': 'school_code',
    'charterschool': 'charter_school',
    'schooltype': 'school_type',
    'gradespan': 'grade_span',
    'totalresident': 'total_resident_children',
    'resident_children': 'total_resident_children',
    'schoolserved': 'school_served',
    'eligibility_programmodel': 'eligibility_model',
    'eligibility_program_model': 'eligibility_model',
    'eligibilityjustification': 'eligibility_justification',
    'programjustification': 'program_justification',
    'served1st_year': 'served_1st_year',
    'served1st_yearcomment': 'served_1st_year_comment',
    'year': 'school_year',
    'schoolyear': 'school_year',
    'number_studentsservedtas': 'served_tas_count',
    'number_students_servedtas': 'served_tas_count',
    'gradesservedtas': 'served_tas_grade',
    'grades_served_tas': 'served_tas_grade',
    'low_income_students': 'number_low_income_students',
    'number_lowincome': 'number_low_income_students',
    'percent': 'percent_low_income_students',
    'percent_lowincome': 'percent_low_income_students',
}

def clean(row):
    ret = []
    for c in row:
        c = c.replace('\n', ' ')
        c = c.replace('-', ' ')
        c = c.replace('%', ' percent ')
        c = c.replace('#', ' number ')
        c = '_'.join(c.split())
        c = c.lower()
        c = HEADER_MAP.get(c, c)
        ret.append(c)
    return ret

if __name__ == '__main__':
    reader = csv.reader(sys.stdin)
    writer = csv.writer(sys.stdout)

    header = next(reader)
    writer.writerow(clean(header))
    for row in reader:
        writer.writerow(row)
