﻿using System;
using System.Collections.Generic;

namespace generate.core.Models.IDS
{
    public partial class RefServiceFrequency
    {
        public RefServiceFrequency()
        {
            IndividualizedProgramService = new HashSet<IndividualizedProgramService>();
        }

        public int RefServiceFrequencyId { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public string Definition { get; set; }
        public int? RefJurisdictionId { get; set; }
        public decimal? SortOrder { get; set; }

        public virtual ICollection<IndividualizedProgramService> IndividualizedProgramService { get; set; }
        public virtual Organization RefJurisdiction { get; set; }
    }
}