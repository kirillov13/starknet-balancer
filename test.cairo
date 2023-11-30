let mut unique_elements = (*t.data).unique();
let mut new_shape: Array<usize> = array![unique_elements.len()];

// TODO: investigate why calling merge before the next 2 loops
// cause the program to crash with error:
// #73054: One of the arguments does not satisfy the requirements of the libfunc.
if (sorted) {
    unique_elements = merge(unique_elements);
    // unique_elements = unique_elements;
}

let mut unique_elements_span = unique_elements.span();
let mut data_cpy = *(t.data);
loop {
    match unique_elements_span.pop_front() {
        Option::Some(value) => {
            let occurences = data_cpy.occurrences_of(*value);
            count.append(occurences.into());
            let idx_in_data = data_cpy.index_of(*value).unwrap();
            indices.append(idx_in_data.into());
        },
        Option::None => { break; }
    }
};
unique_elements_span = unique_elements.span();
loop {
    match data_cpy.pop_front() {
        Option::Some(value) => {
            let idx_in_uniques = unique_elements_span.index_of(*value).unwrap();
            inverse_indices.append(idx_in_uniques.into());
        },
        Option::None => { break; }
    }
};
