from datetime import datetime

def person_register_validate_form_or_errors(data):
    errors = []
    if not 'name' in data:
        errors.append('Name is required')
    else:
        if len(data['name']) < 3:
            errors.append('Name must be at least 3 characters')
    if not 'username' in data:
        errors.append('Username is required')
    else:
        if len(data['username']) < 3:
            errors.append('Username must be at least 5 characters')
    if not 'password' in data:
        errors.append('Password is required')
    else:
        if len(data['password']) < 3:
            errors.append('Password must be at least 8 characters')
    return errors


def event_register_validate_form_or_errors(data):
    errors = []
    if not 'title' in data:
        errors.append('title is required')
    else:
        if len(data['title']) < 5:
            errors.append('title must be at least 5 characters')
    if not 'expiration_date' in data:
        errors.append('expiration_date is required')
    else:
        if len(data['expiration_date']) == 0:
            errors.append('expiration_date is required')
        try:
            expiration_date = datetime.fromisoformat(data['expiration_date'])
            current_date = datetime.now()
            if expiration_date <= current_date:
                errors.append('expiration_date must be greater than current date')
        except:
            errors.append('Invalid date format')
    return errors


def response_register_validate_form_or_errors(data):
    errors = []
    
    if not 'guest_name' in data:
        errors.append('guest_name is required')
    else:
        if len(data['guest_name']) < 3:
            errors.append('guest_name must be at least 3 characters')
    if not 'confirm' in data:
        errors.append('confirm is required')
    else:
        if type(data['confirm']) is not bool:
            errors.append('confirm must be boolean data')

    return errors
