//  Copyright (c) 2016 Hartmut Kaiser
//
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

#include <hpx/config.hpp>

#if defined(HPX_HAVE_PARCELPORT_ACTION_COUNTERS)

#include <hpx/runtime/parcelset/detail/per_action_data_counter.hpp>

#include <cstdint>
#include <map>
#include <mutex>
#include <string>

namespace hpx { namespace parcelset { namespace detail
{
    // add collected data
    void per_action_data_counter::add_data(
        std::string const& action,
        performance_counters::parcels::data_point const& data)
    {
        std::lock_guard<mutex_type> l(mtx_);
        data_[action].add_data(data);
    }

    // retrieve counter data

    // number of parcels handled
    std::int64_t per_action_data_counter::num_parcels(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].num_parcels(reset);
    }

    // number of messages handled
    std::int64_t per_action_data_counter::num_messages(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].num_messages(reset);
    }

    // the total time it took to handle all parcels (nanoseconds)
    std::int64_t per_action_data_counter::total_time(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].total_time(reset);
    }

    // the total time serialization took (nanoseconds)
    std::int64_t per_action_data_counter::total_serialization_time(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].total_serialization_time(reset);
    }

#if defined(HPX_HAVE_SECURITY)
    // the total time security operations took (nanoseconds)
    std::int64_t per_action_data_counter::total_security_time(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].total_security_time(reset);
    }
#endif

    // total data managed (bytes)
    std::int64_t per_action_data_counter::total_bytes(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].total_bytes(reset);
    }

    // total data (uncompressed) handled (bytes)
    std::int64_t per_action_data_counter::total_raw_bytes(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].total_raw_bytes(reset);
    }

    std::int64_t per_action_data_counter::total_buffer_allocate_time(
        std::string const& action, bool reset)
    {
        std::lock_guard<mutex_type> l(mtx_);
        return data_[action].total_buffer_allocate_time(reset);
    }
}}}

#endif
