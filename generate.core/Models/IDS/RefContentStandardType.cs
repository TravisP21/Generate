﻿using System;
using System.Collections.Generic;

namespace generate.core.Models.IDS
{
    public partial class RefContentStandardType
    {
        public RefContentStandardType()
        {
            AssessmentSubtest = new HashSet<AssessmentSubtest>();
        }

        public int RefContentStandardTypeId { get; set; }
        public string Description { get; set; }
        public string Code { get; set; }
        public string Definition { get; set; }
        public int? RefJurisdictionId { get; set; }
        public decimal? SortOrder { get; set; }

        public virtual ICollection<AssessmentSubtest> AssessmentSubtest { get; set; }
        public virtual Organization RefJurisdiction { get; set; }
    }
}